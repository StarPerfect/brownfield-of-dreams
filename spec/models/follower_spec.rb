require 'rails_helper'

describe Follower do
  it 'exists' do
    attrs = {
      login: 'HeatherHerries',
      html_url: 'https://github.com/HeatherHerries'
    }

    follower = Follower.new(attrs)

    expect(follower).to be_a Follower
    expect(follower.login).to eq('HeatherHerries')
    expect(follower.html_url).to eq('https://github.com/HeatherHerries')
  end
end
