require "tictactoe/board"

class WebDisplay
  INVALID_MOVE = -1
  OFFSET_FOR_DISPLAY = 1

  attr_reader :board

  def display_board(board)
    @board = board
  end

  def formatted_board
    format_board
  end

  def store_next_move(move)
    @next_move = move
  end

  def ask_for_move
    if has_move?
      return pop_move
    end
    next_move
  end

  private

  def has_move?
    next_move != INVALID_MOVE
  end

  def pop_move
    popped_move = next_move
    @next_move = INVALID_MOVE
    popped_move
  end

  def format_board
    result = board.board_cells.flatten.collect.with_index do |cell, index|
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

  attr_reader :next_move
end
