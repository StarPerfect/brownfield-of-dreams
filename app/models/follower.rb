class Follower
  attr_reader :login, :html_url

  def initialize(data = {})
    @login = data[:login]
    @html_url = data[:html_url]
  end
end
