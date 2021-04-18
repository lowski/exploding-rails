require 'rails_helper'

RSpec.describe ProjectContract do
  subject(:contract) { described_class.new }

  context 'with name provided' do
    let(:attributes) { Hash[name: 'Test'] }

    specify do
      expect(contract.call(attributes)).to be_success
    end
  end

  context 'without name' do
    let(:attributes) { Hash[] }

    specify do
      result = contract.call(attributes)
      expect(result).to be_failure
      expect(result.errors[:name]).to include('is missing')
    end
  end
end
