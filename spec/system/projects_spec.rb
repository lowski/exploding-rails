require 'rails_helper'

RSpec.describe "Projects", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'creating a new project' do
    context 'with valid attributes' do
      specify do
        visit '/'
        click_link 'New Project'
        fill_in 'Name', with: 'NeoVIM'
        click_button 'Create Project'

        expect(page).to have_text('Project has been created')
      end
    end

    context 'with invalid attributes' do
      specify do
        visit '/'
        click_link 'New Project'
        click_button 'Create Project'

        expect(page.current_path).to eq('/projects')
        expect(page).to have_text('Project could not be created')
        expect(page).to have_text('Name must be filled')
      end
    end
  end

  describe 'viewing projects' do
    let!(:project) { repo.create(name: 'Vim') }
    let(:repo) { ProjectRepository.new(ROM.env) }

    context 'with the project details' do
      specify do
        visit '/'
        click_link 'Vim'

        expect(page.current_path).to eq("/projects/#{project.id}")
        within('h2') do
          expect(page).to have_text('Vim')
        end
      end
    end
  end
end
