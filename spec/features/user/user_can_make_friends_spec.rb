require 'rails_helper'

RSpec.describe 'As a registered user', type: :feature do
  context 'When I visit my dashboard' do
    before :each do
      repos_response = File.open("./fixtures/github_repo.json")
      stub_request(:get, "https://api.github.com/user/repos").to_return(status: 200, body: repos_response)
      followers_response = File.open("./fixtures/github_followers.json")
      stub_request(:get, "https://api.github.com/user/followers").to_return(status: 200, body: followers_response)
      following_response = File.open("./fixtures/github_following.json")
      stub_request(:get, "https://api.github.com/user/following").to_return(status: 200, body: following_response)
      email_response = File.open("./fixtures/user_email.json")
      stub_request(:get, "https://api.github.com/users/StarPerfect").to_return(status: 200, body: email_response)
      sad_response = File.open("./fixtures/sadpath_email.json")
      stub_request(:get, "https://api.github.com/users/sadpathtylor").to_return(status: 200, body: sad_response)
      no_response = File.open("./fixtures/nopath_email.json")
      stub_request(:get, "https://api.github.com/users/nopathuser").to_return(status: 200, body: no_response)
      @user = create(:user, github_token: '12345', github_uid: '09876')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I can see Add as Friend button on unfriended users' do
      visit dashboard_path

      within('#github-follower-kylecornelissen') do
        expect(page).to have_button('Add as Friend')
      end

      within('#github-follower-davehardy632') do
        expect(page).to have_button('Add as Friend')
      end

      within('#github-follower-MillsProvosty') do
        expect(page).to have_button('Add as Friend')
      end

      within('#github-follower-lpile') do
        expect(page).to_not have_button('Add as Friend')
      end
    end
  end
end
