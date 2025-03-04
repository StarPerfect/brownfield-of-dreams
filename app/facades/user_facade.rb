class UserFacade
  def initialize(current_user)
    @current_user = current_user
    @service = GithubApiService.new(current_user.github_token)
  end

  def repos
  @service.get_user_repos.map do |data|
      Repo.new(data)
    end.take(5)
  end

  def followers
  @service.get_user_followers.map do |data|
      GithubUser.new(data)
    end
  end

  def following
    @service.get_user_following.map do |data|
      GithubUser.new(data)
    end
  end

  def email(username)
    GithubUser.new(@service.get_user_email(username))
  end

  def bookmarked_tutorials
    current_user.bookmarks
  end

private
  attr_reader :current_user
end
