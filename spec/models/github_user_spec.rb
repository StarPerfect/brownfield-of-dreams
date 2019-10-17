require 'rails_helper'

describe GithubUser do
  it 'exists' do
    attrs = {
      login: 'HeatherHerries',
      html_url: 'https://github.com/HeatherHerries'
    }

    user = GithubUser.new(attrs)

    expect(user).to be_a GithubUser
    expect(user.login).to eq('HeatherHerries')
    expect(user.html_url).to eq('https://github.com/HeatherHerries')
  end

  describe 'instance methods' do
    it '#registered?' do
      attributes = { login: 'Joey Fatone',
                   html_url: 'https://joeyfatone.com',
                   id: '14723' }

      @user = GithubUser.new(attributes)
      create(:user, github_uid: '14723')
      unregistered_user = GithubUser.new(id: '1738')

      expect(@user.registered?).to eq(true)
      expect(unregistered_user.registered?).to eq(false)
    end
  end
end
