# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see another section titled "Followers"
# And I should see list of all followers with their handles linking to their Github profile
require 'rails_helper'

describe 'User Dashboard View' do
  describe 'As a logged in user visiting my dashboard' do
    before :each do
      repos_response = File.open("./fixtures/github_repo.json")
      stub_request(:get, "https://api.github.com/user/repos").to_return(status: 200, body: repos_response)
      followers_response = File.open("./fixtures/github_followers.json")
      stub_request(:get, "https://api.github.com/user/followers").to_return(status: 200, body: followers_response)
    end

    it 'I should see a Followers section within the GitHub section with all my followers and links to their profile' do
      user = User.create!(first_name: 'Bob', last_name: 'Ross', password: 'HappyTree', github_token: '12345', email: 'Mr.Ross@gmail.com')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('GitHub')

      within(".github") do
        expect(page).to have_content('Followers')
      end

      within(first('.followers')) do
        expect(page).to have_css('.user')
        expect(page).to have_link('HeatherHerries')
      end
    end
  end
end
