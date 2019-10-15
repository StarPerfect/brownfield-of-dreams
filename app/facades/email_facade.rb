class EmailFacade
  def initialize(current_user)
    @current_user = current_user
    @service = GithubApiService.new(current_user.github_token)
  end

  def email(username)
    UserEmail.new(@service.get_user_email(username))
  end

private
  attr_reader :current_user
end
