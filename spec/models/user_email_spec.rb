require 'rails_helper'

describe UserEmail do
  it 'exists' do
    attrs = {
      login: 'StarPerfect',
      email: 'StarPerfect@gmail.com'
    }

    user = UserEmail.new(attrs)

    expect(user).to be_a UserEmail
    expect(user.login).to eq('StarPerfect')
    expect(user.email).to eq('StarPerfect@gmail.com')
  end
end
