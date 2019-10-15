class UserEmail
  attr_reader :login, :email

  def initialize(data = {})
    @login = data[:login] || nil
    @email = data[:email] || nil
  end
end
