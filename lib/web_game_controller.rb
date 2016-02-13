require "tictactoe/game"
require "tictactoe/board"

class WebGameController
  def initialize(player_factory, display)
    @player_factory = player_factory
    @display = display
  end
 
  def ready_to_play?
    !@game.nil?
  end

  def create_game(dimension, game_type)
    @dimension = dimension.to_i
    @game_type = game_type
    @players = player_factory.get_players_for_game_type(game_type)
    @board = TicTacToe::Board.new(dimension)
    display.display_board(board)
    @game = TicTacToe::Game.new(board, game_type, display, players)
  end

  private

  attr_reader :player_factory, :game_type, :dimension, :players, :display, :board
end
