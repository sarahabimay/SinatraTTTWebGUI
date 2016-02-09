require "sinatra/base"
require "tilt/erb"
require "tictactoe/board_options"
require "tictactoe/game_type_options"

class WebApp < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/../views'
  enable :sessions

  get '/' do
    @dimensions = TicTacToe::BoardOptions::DIMENSIONS
    @game_types = TicTacToe::GameTypeOptions::GAME_OPTIONS
    erb :game_options
  end
end
