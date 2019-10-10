class GithubApiService
  def get_user_repos
    get_response('/user/repos')
  end

  private

  def get_response(url)
    json_response = conn.get(url)
    JSON.parse(json_response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.github.com/") do |f|
      f.headers['Authorization'] =  "token " + ENV['github_token']
      f.adapter Faraday.default_adapter
    end
  end
end
