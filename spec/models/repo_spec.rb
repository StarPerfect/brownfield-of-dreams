require 'rails_helper'

describe Repo do
  it 'exists' do
    attrs = {
      name: 'cross-check',
      html_url: 'https://github.com/nancylee713/cross_check'
    }

    repo = Repo.new(attrs)

    expect(repo).to be_a Repo
    expect(repo.name).to eq('cross-check')
    expect(repo.html_url).to eq('https://github.com/nancylee713/cross_check')
  end
end
