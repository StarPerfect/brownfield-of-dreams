require 'rails_helper'

describe Following do
  it 'exists' do
    attrs = {
      login: 'Martsy',
      html_url: 'https://github.com/Martsy'
    }

    following = Following.new(attrs)

    expect(following).to be_a Following
    expect(following.login).to eq('Martsy')
    expect(following.html_url).to eq('https://github.com/Martsy')
  end
end
