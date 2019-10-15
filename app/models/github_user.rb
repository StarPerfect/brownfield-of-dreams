class GithubUser
  attr_reader :login, :html_url, :email

  def initialize(data = {})
    @login = data[:login] || nil
    @html_url = data[:html_url]
    @email = data[:email] || nil
  end
end
