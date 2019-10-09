class UserFacade
  attr_reader :current_user

  def initialize(current_user)
    @current_user = current_user
  end

  def repos
    conn = Faraday.new(url: "https://api.github.com/") do |f|
      f.headers['Authorization'] =  "token " + ENV['github_token']
      f.adapter Faraday.default_adapter
    end

    json_response = conn.get("/user/repos")

    parsed_data = JSON.parse(json_response.body, symbolize_names: true)

    parsed_data.map do |data|
      Repo.new(data)
    end
  end


end



# def self.get_repos(username)
#   json_response = conn.get("/#{username}/repos")
#   parsed_data = JSON.data(json_response.body, symbolize_names: true)
# end
#
# private
#
# def conn
#   Faraday.new(
#     url: 'https://api.github.com/users',
#     headers: {'Accept' => 'application/vnd.github.v3+json',
#               'Authorization' => ENV['github_token']},
#   )
# end
