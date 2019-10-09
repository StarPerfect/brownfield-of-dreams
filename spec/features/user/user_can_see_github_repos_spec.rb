require 'rails_helper'

describe 'User Dashboard View' do
  describe 'As a logged in user, when I visit /dashboard' do
    before :each do
      VCR.turn_off!
      WebMock.allow_net_connect!

      json_response = File.open("./fixtures/github_repo.json")
      stub_request(:get, "https://api.github.com/user/repos").to_return(status: 200, body: json_response)
    end

    it 'Then I should see a section for "Github" with 5 repo names' do
      user = User.create!(first_name: 'Bob', last_name: 'Ross', password: 'HappyTree', github_token: '12345', email: 'Mr.Ross@gmail.com')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('GitHub')

      within(first(".repo")) do
        expect(page).to have_css('.name')
      end
    end
  end
end
