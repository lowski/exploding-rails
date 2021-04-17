require 'rails_helper'

RSpec.describe "Projects", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'creating new project by user' do
    context 'with valid attributes' do
      specify do
        visit '/'
        click_link 'New Project'
        fill_in 'Name', with: 'NeoVIM'
        click_button 'Create Project'

        expect(page).to have_text('Project has been created')
      end
    end
  end
end
