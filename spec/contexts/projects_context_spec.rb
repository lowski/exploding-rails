require 'rails_helper'

RSpec.describe ProjectsContext do
  subject(:projects) { described_class.new(repo, contract) }

  let(:repo) { instance_double(ProjectRepository) }
  let(:contract) { instance_double(ProjectContract) }

  describe '#create' do
    let(:attributes) { Hash[name: 'Test'] }
    let(:project) { Factory.structs[:project, **attributes] }

    before do
      expect(contract).to receive(:call).with(attributes).and_return(validation_result)
    end

    context 'with valid values' do
      let(:validation_result) { instance_double(Dry::Validation::Result, success?: true, values: attributes) }

      before do
        expect(repo).to receive(:create).with(attributes).and_return(project)
      end

      specify do
        expect(projects.create(attributes))
          .to be_success
          .and have_attributes(value!: project)
      end
    end

    context 'with invalid values' do
      let(:attributes) { Hash[name: ''] }
      let(:validation_result) { instance_double(Dry::Validation::Result, success?: false, errors: :errors, values: attributes) }

      before do
        expect(repo).to receive(:build).with(attributes).and_return(project)
      end

      specify do
        expect(projects.create(attributes))
          .to be_failure
          .and have_attributes(failure: include(project: project, errors: :errors))
      end
    end
  end

  describe '#destroy' do
    context 'with valid id' do
      let(:project) { Factory.structs[:project, id: 1] }

      before do
        expect(repo).to receive(:delete).with(1).and_return(project)
      end

      specify do
        expect(projects.destroy(project)).to be_success
      end
    end

    context 'with invalid id' do
      let(:project) { Factory.structs[:project, id: -1] }

      before do
        expect(repo).to receive(:delete).with(-1).and_return(nil)
      end

      specify do
        expect(projects.destroy(project)).to be_failure
      end
    end
  end
end
