class UserFacade
  def initialize(current_user)
    @current_user = current_user
  end

  def repos
    service = GithubApiService.new
    service.get_user_repos.map do |data|
      Repo.new(data)
    end.take(5)
  end

private

  attr_reader :current_user
end
