require "tictactoe/game"
require "tictactoe/board"

class WebGameCreate
  attr_reader :game_type, :dimension, :display

  def initialize(params, session, player_factory, display)
    @session = session
    @player_factory = player_factory
    @display = display
    @dimension = dimension_description_to_value(params["dimension"]).to_i
    @game_type = game_type_description_to_value(params["game_type"])
    @game = create_game
  end

  def ready_to_play?
    !@game.nil?
  end

  def play(params)
    play_move(params)
    display_result
  end

  private

  attr_reader :player_factory, :players, :game, :session

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
    board_cells = session[:board_cells]
    if board_cells.nil?
      board = TicTacToe::Board.new(dimension)
      update_session_with_new_board(board)
    else
      board = TicTacToe::Board.new(dimension, board_cells.each_slice(dimension).to_a)
    end
    board
  end

  def play_move(params)
    position = params["position"]
    if !position.nil?
      display.display_move(position)
      game.play_turns
      update_session_with_new_board(game.board)
    end
  end

  def update_session_with_new_board(board)
    session[:board_cells] = board.board_cells.flatten
  end

  def display_result
    if(display.board.is_game_over?)
      display.set_game_state(is_in_play: false)
      display.display_win(game.get_winning_mark) if winning_mark_found?
    end
  end

  def winning_mark_found?
    TicTacToe::Mark::is_a_mark?(game.get_winning_mark)
  end
end
