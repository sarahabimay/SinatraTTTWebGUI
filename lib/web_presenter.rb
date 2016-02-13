require "tictactoe/board_options"
require "tictactoe/game_type_options"

class WebPresenter
  OFFSET_FOR_DISPLAY = 1

  def initialize(web_game)
    @web_game = web_game
  end

  def game_type
    TicTacToe::GameTypeOptions::ID_TO_GAME_TYPE[web_game.game_type]
  end

  def dimension_description
    TicTacToe::BoardOptions::DIMENSIONS.key(web_game.dimension)
  end

  def board_dimension
    web_game.dimension
  end

  def all_dimensions
    TicTacToe::BoardOptions::DIMENSIONS
  end

  def all_game_types
    TicTacToe::GameTypeOptions::GAME_OPTIONS
  end

  def board_cells
    format_board
  end

  def game_result
    web_game.display.result
  end

  private

  attr_reader :web_game

  def format_board
    result = web_game.display.board.board_cells.flatten.collect.with_index do |cell, index|
      format_cells_for_display(cell, index)
    end
    result.each_slice(3).to_a
  end

  def format_cells_for_display(cell, index)
    if cell.nil?
      cell = index + OFFSET_FOR_DISPLAY
    end
    cell.to_s
  end
end
