require "tictactoe/game"
require "tictactoe/game_type_options"
require "tictactoe/board_options"
require "tictactoe/board"

class WebGameCreate
  attr_reader :game_type, :dimension, :display, :game

  def initialize(params, player_factory, display)
    @player_factory = player_factory
    @display = display
    @dimension = dimension_description_to_value(params["dimension"]).to_i
    @game_type = game_type_description_to_value(params["game_type"])
    @board_cells = params["board_cells"]
    @game = create_game
  end

  def ready_to_play?
    !@game.nil?
  end

  private

  attr_reader :player_factory, :players, :board_cells

  def dimension_description_to_value(dimension_description)
    TicTacToe::BoardOptions::DIMENSIONS[dimension_description]
  end

  def game_type_description_to_value(game_type_description)
    TicTacToe::GameTypeOptions::ID_TO_GAME_TYPE.key(game_type_description)
  end

  def create_game
    @players = player_factory.get_players_for_game_type(game_type)
    board = create_board(dimension)
    display.display_board(board)
    @game = TicTacToe::Game.new(board, game_type, display, players)
  end

  def create_board(dimension)
    if board_cells.nil?
      board = TicTacToe::Board.new(dimension)
    else
      board = TicTacToe::Board.new(dimension, board_cells.each_slice(dimension).to_a)
    end
    board
  end
end
