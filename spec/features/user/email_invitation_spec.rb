# As a registered user
# When I visit /dashboard
# And I click "Send an Invite"
# Then I should be on /invite
#
# And when I fill in "Github Handle" with <A VALID GITHUB HANDLE>
# And I click on "Send Invite"
# Then I should be on /dashboard
# And I should see a message that says "Successfully sent invite!" (if the user has an email address associated with their github account)
# Or I should see a message that says "The Github user you selected doesn't have an email address associated with their account."
require 'rails_helper'

describe 'Email Invitation Feature' do
  describe 'a registered user can visit /dashboard' do
    before :each do
      json_response = File.open("./fixtures/github_repo.json")
      stub_request(:get, "https://api.github.com/user/repos").to_return(status: 200, body: json_response)
      followers_response = File.open("./fixtures/github_followers.json")
      stub_request(:get, "https://api.github.com/user/followers").to_return(status: 200, body: followers_response)
      following_response = File.open("./fixtures/github_following.json")
      stub_request(:get, "https://api.github.com/user/following").to_return(status: 200, body: following_response)
      user = User.create!(first_name: 'Bob', last_name: 'Ross', password: 'HappyTree', github_token: '12345', email: 'Mr.Ross@gmail.com')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    it "can see a link to 'Send an Invite' which takes them to an email invitation page" do
      visit dashboard_path

      click_button('Send an Invite')

      expect(current_path).to eq('/invite')
    end

    it 'can enter valid GitHub handle and send an invitation' do
      visit invite_path

      fill_in :github_user, with: 'StarPerfect'

      click_o 'Send Invite'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Successfully sent invite!')
    end

    it 'can enter invalid GitHub handle and see an error message' do
      visit invite_path

      fill_in :github_user, with: 'SadPathUser'

      click_on 'Send Invite'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
    end
  end
end
