ENV["RACK_ENV"] = "test"
require "rack/test"
require "web_app"

RSpec.describe WebApp do
  include Rack::Test::Methods
 
  def app
    WebApp
  end

  it "get '/': options page" do
    get '/'
    expect(last_response.body).to include("Tic Tac Toe Game")
    expect(last_response.body).to include("Please Choose Your Game Options:")
    expect(last_response.body).to include("Board Dimensions:")
    expect(last_response.body).to include("THREE_BY_THREE")
    expect(last_response.body).to include("Human Vs Human")
  end

  it "get '/game/create': page" do
    get "/game/create?dimension=THREE_BY_THREE&game_type=HVH"
    expect(last_response.body).to include("Tic Tac Toe Game : HVH")
    expect(last_response.body).to include("id=1")
  end
end
