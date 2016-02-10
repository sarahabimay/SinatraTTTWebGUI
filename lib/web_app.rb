require "sinatra/base"
require "tilt/erb"
require "tictactoe/board_options"
require "tictactoe/game_type_options"
require "web_player_factory"
require "web_game_controller"
require "web_display"

class WebApp < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/../views'
  enable :sessions

  get '/' do
    @dimensions = TicTacToe::BoardOptions::DIMENSIONS
    @game_types = TicTacToe::GameTypeOptions::GAME_OPTIONS
    erb :game_options
  end

  get '/game/create' do
    session[:game_type] = params["game_type"]
    session[:dimension] = params["dimension"]
    @game_type = session[:game_type]
    @dimension = session[:dimension]
    @display = WebDisplay.new
    @game_controller = WebGameController.new(WebPlayerFactory.new(display), display)
    game_controller.create_game(dimension_description_to_value(dimension), game_type_description_to_value(game_type))
    erb :game_layout
  end

  private

  def dimension_description_to_value(dimension_description)
    TicTacToe::BoardOptions::DIMENSIONS[dimension_description] 
  end

  def game_type_description_to_value(game_type_description)
    TicTacToe::GameTypeOptions::ID_TO_GAME_TYPE.key(game_type_description) 
  end

  attr_reader :game_controller, :display, :game_type, :dimension
end
