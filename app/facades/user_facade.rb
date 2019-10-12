class UserFacade
  def initialize(current_user)
    @current_user = current_user
    @service = GithubApiService.new
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

private
  attr_reader :current_user
end
