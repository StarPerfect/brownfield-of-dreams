class GithubApiService
  def initialize(github_token)
    @github_token = github_token
  end

  def get_user_repos
    get_response('/user/repos')
  end

  def get_user_followers
    get_response('/user/followers')
  end

  def get_user_following
    get_response('/user/following')
  end

  private

  def get_response(url)
    json_response = conn.get(url)
    JSON.parse(json_response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.github.com/") do |f|
      f.headers['Authorization'] =  "token #{@github_token}"
      f.adapter Faraday.default_adapter
    end
  end
end
