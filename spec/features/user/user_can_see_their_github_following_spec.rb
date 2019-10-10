require 'rails_helper'

describe "User Following Section" do
  describe "As a logged in user, when I visit '/dashboard'" do
    it "I see a section 'Following' and underneath I see a list of Github users I follow" do
      json_response = File.open("./fixtures/github_repo.json")
      stub_request(:get, "https://api.github.com/user/repos").to_return(status: 200, body: json_response)
      followers_response = File.open("./fixtures/github_followers.json")
      stub_request(:get, "https://api.github.com/user/followers").to_return(status: 200, body: followers_response)
      following_response = File.open("./fixtures/github_following.json")
      stub_request(:get, "https://api.github.com/user/following").to_return(status: 200, body: following_response)

      user = User.create!(first_name: 'Bob', last_name: 'Ross', password: 'HappyTree', github_token: '12345', email: 'Mr.Ross@gmail.com')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Following')

      within(first('.following')) do
        expect(page).to have_css('.login')
        expect(page).to have_link('Martsy')
      end
    end
  end
end
