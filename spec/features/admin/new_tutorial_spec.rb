# When I visit '/admin/tutorials/new'
# And I fill in 'title' with a meaningful name
# And I fill in 'description' with a some content
# And I fill in 'thumbnail' with a valid YouTube thumbnail
# And I click on 'Save'
# Then I should be on '/tutorials/{NEW_TUTORIAL_ID}'
# And I should see a flash message that says "Successfully created tutorial."
require 'rails_helper'

describe 'Add New Tutorial by Admin' do
  describe 'As an admin, when I visit the new tutorial path' do
    before :each do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    end

    it 'Can submit details and create a new tutorial' do
      visit new_admin_tutorial_path

      fill_in 'Title', with: 'A Meaningful Name'
      fill_in 'Description', with: 'Some Content'
      fill_in 'Thumbnail', with: 'https://i.ytimg.com/vi/9STzCNiCVNQ/mqdefault.jpg'

      click_on 'Save'

      tutorial = Tutorial.last

      expect(current_path).to eq("/tutorials/#{tutorial.id}")
      expect(page).to have_content('Successfully created tutorial.')
    end

    it 'can give error messages if incomplete information' do
      visit new_admin_tutorial_path

      fill_in 'Title', with: nil
      fill_in 'Description', with: nil
      fill_in 'Thumbnail', with: nil

      click_on 'Save'

      expect(current_path).to eq(new_admin_tutorial_path)
      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content("Description can't be blank")
      expect(page).to have_content("Thumbnail can't be blank")
    end
  end
end
