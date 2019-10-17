class GithubUser
  attr_reader :login,
              :html_url,
              :uid

  def initialize(data = {})
    @login = data[:login]
    @html_url = data[:html_url]
    @uid = data[:id]
  end

  def registered?
    !User.find_by(github_uid: @uid).nil?
  end
end
