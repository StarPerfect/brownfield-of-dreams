# As a user
# When I visit /dashboard
# Then I should see a link that is styled like a button that says "Connect to Github"
# And when I click on "Connect to Github"
# Then I should go through the OAuth process
# And I should be redirected to /dashboard
# And I should see all of the content from the previous Github stories (repos, followers, and following)

require 'rails_helper'

describe 'OmniAuth Authorization' do
  describe 'As a user visiting my dashboard' do
    describe 'I can see a Connect to GitHub button' do
      before :each do
        OmniAuth.config.test_mode = true
        OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
          credentials: {
            :token => '123'
          },
          info: {
            :nickname => 'StarPerfect'
          }
        )
        Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
        json_response = File.open("./fixtures/github_repo.json")
        stub_request(:get, "https://api.github.com/user/repos").to_return(status: 200, body: json_response)
        followers_response = File.open("./fixtures/github_followers.json")
        stub_request(:get, "https://api.github.com/user/followers").to_return(status: 200, body: followers_response)
        following_response = File.open("./fixtures/github_following.json")
        stub_request(:get, "https://api.github.com/user/following").to_return(status: 200, body: following_response)
      end

      it 'can click button to go through the OAuth process' do
        user = User.create!(first_name: 'Cindy', last_name: 'Loo', password: 'Whoo', email: 'grinchstolemyxmas@gmail.com')
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit dashboard_path

        click_button 'Connect to GitHub'

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content('GitHub')
        expect(page).to have_content('Followers')
        expect(page).to have_content('Following')

        within(first('.following')) do
          expect(page).to have_css('.login')
        end

        within(first(".repo")) do
          expect(page).to have_css('.name')
        end

        within(first('.followers')) do
          expect(page).to have_css('.user')
        end
      end
    end
  end
end
