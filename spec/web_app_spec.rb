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
    expect(last_response.body).to include("Player Types:")
  end
end
