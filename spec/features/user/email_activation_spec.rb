require 'rails_helper'

describe 'User Registration' do
  describe "when a guest user visits '/' and clicks Register" do
    it 'can complete the registration form and register for the site' do
      visit '/'

      click_link 'Register'

      expect(current_path).to eq('/register')

      fill_in :user_email, with: 'StarPerfect@gmail.com'
      fill_in :user_first_name, with: 'Corina'
      fill_in :user_last_name, with: 'Allen'
      fill_in :user_password, with: 'Hello123'
      fill_in :user_password_confirmation, with: 'Hello123'

      click_button 'Create Account'

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content('Logged in as Corina Allen')
      expect(page).to have_content('This account has not yet been activated. Please check your email.')
    end
  end

  describe 'Email Activation' do
    it 'can click link in email and go to activated page' do
      user = User.create!(first_name: 'Bob', last_name: 'Ross', password: 'HappyTree', status: 'inactive', email: 'Mr.Ross@gmail.com')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/users/#{user.id}/activate"
    end
  end
end

#
# Background: The registration process above will trigger this story
#
# As a non-activated user
# When I check my email for the registration email
# I should see a message that says "Visit here to activate your account."
# And when I click on that link
# Then I should be taken to a page that says "Thank you! Your account is now activated."
#
# And when I visit "/dashboard"
# Then I should see "Status: Active"
