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
end
