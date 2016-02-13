ENV["RACK_ENV"] = "test"
require "rack/test"
require "web_app"

RSpec.describe WebApp do
  include Rack::Test::Methods

  let(:x_win_announcement) { "Player X is the Winner!" }
  let(:draw_announcement) { "Game Over! The game is a Draw!" }

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
    expect(last_response.body).to include("GAME RESULTS:")
    expect(last_response.body).to include("Start Again?")
  end

  it "play one position  'get /game/play?position=1'" do
    get "/game/create?dimension=THREE_BY_THREE&game_type=HVH"
    get "/game/play?position=1"
    expect(last_response.body).to include("X")
  end

  it "play 2 positions 'get '/game/play''" do
    get "/game/create?dimension=THREE_BY_THREE&game_type=HVH"
    get "/game/play?position=1"
    get "/game/play?position=3"
    expect(last_response.body).to include("X")
    expect(last_response.body).to include("O")
  end

  it "play game till win displayed" do
    get "/game/create?dimension=THREE_BY_THREE&game_type=HVH"
    get "/game/play?position=1"
    get "/game/play?position=4"
    get "/game/play?position=2"
    get "/game/play?position=5"
    get "/game/play?position=3"
    expect(last_response.body).to include(x_win_announcement)
  end

  it "play game till draw displayed" do
    get "/game/create?dimension=THREE_BY_THREE&game_type=HVH"
    get "/game/play?position=1"
    get "/game/play?position=2"
    get "/game/play?position=3"
    get "/game/play?position=5"
    get "/game/play?position=4"
    get "/game/play?position=6"
    get "/game/play?position=8"
    get "/game/play?position=7"
    get "/game/play?position=9"
    expect(last_response.body).to include(draw_announcement)
  end
end
