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
      email_response = File.open("./fixtures/user_email.json")
      stub_request(:get, "https://api.github.com/users/StarPerfect").to_return(status: 200, body: email_response)

      visit invite_path

      fill_in :sendee, with: 'StarPerfect'

      click_on 'Send Invite'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Successfully sent invite!')
    end

    it 'can enter valid GitHub handle that has no public email to see an error message' do
      sad_response = File.open("./fixtures/sadpath_email.json")
      stub_request(:get, "https://api.github.com/users/sadpathtylor").to_return(status: 200, body: sad_response)

      visit invite_path

      fill_in :sendee, with: 'sadpathtylor'

      click_on 'Send Invite'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
    end

    it 'can enter invalid GitHub handle and see an error message' do
      no_response = File.open("./fixtures/nopath_email.json")
      stub_request(:get, "https://api.github.com/users/nopathuser").to_return(status: 200, body: no_response)

      visit invite_path

      fill_in :sendee, with: 'nopathuser'

      click_on 'Send Invite'

      expect(current_path).to eq(invite_path)
      expect(page).to have_content("The handle you entered is not a valid GitHub user. Please try again.")
    end
  end
end
