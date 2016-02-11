require "tictactoe/game"
require "tictactoe/board"

class WebGameCreate
  def initialize(player_factory, display)
    @player_factory = player_factory
    @display = display
  end
 
  def ready_to_play?
    !@game.nil?
  end

  def play(dimension, game_type, session)
    @dimension = dimension.to_i
    @game_type = game_type
    @game = create_game(session)
  end

  def play_move(position, session)
    display.display_move(position)
    game.play_turns
    update_session_with_new_board(session, game.board)
  end

  private

  def create_game(session)
    @players = player_factory.get_players_for_game_type(game_type)
    board = create_board(dimension, session) 
    display.display_board(board)
    @game = TicTacToe::Game.new(board, game_type, display, players)
  end

  def create_board(dimension, session)
    board_cells = session[:board_cells]
    if board_cells.nil?
      board = TicTacToe::Board.new(dimension)
      update_session_with_new_board(session, board)
    else
      board = TicTacToe::Board.new(dimension, board_cells.each_slice(dimension).to_a)
    end
    board 
  end

  def update_session_with_new_board(session, board)
    session[:board_cells] = board.board_cells.flatten
  end

  attr_reader :player_factory, :game_type, :dimension, :players, :display, :game
end
