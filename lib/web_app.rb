require "sinatra/base"
require "tilt/erb"
require "tictactoe/board_options"
require "tictactoe/game_type_options"
require "web_player_factory"
require "web_game_create"
require "web_display"
require "web_presenter"

class WebApp < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/../views'
  set :public_folder, File.dirname(__FILE__) + '/assets'
  enable :sessions

  get '/' do
    @presenter = WebPresenter.new(nil)
    erb :game_options
  end

  get '/game/create' do
    add_params_to_session
    display = WebDisplay.new
    web_game = WebGameCreate.new(WebPlayerFactory.new(display), display)
    web_game.play(params, session)
    @presenter = WebPresenter.new(web_game)
    erb :game_layout
  end

  get '/game/play' do
    add_session_to_params
    display = WebDisplay.new
    web_game = WebGameCreate.new(WebPlayerFactory.new(display), display)
    web_game.play(params, session)
    web_game.play_move(params["position"], session)
    @presenter = WebPresenter.new(web_game)
    erb :game_layout
  end

  private

  attr_reader :web_game, :display, :game_type, :dimension

  def add_session_to_params
    params["game_type"] = session[:game_type]
    params["dimension"] = session[:dimension]
  end
  
  def add_params_to_session
    session[:game_type] = params["game_type"]
    session[:dimension] = params["dimension"]
  end
end
