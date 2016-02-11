require "tictactoe/board"

class WebDisplay
  INVALID_MOVE = -1
  OFFSET_FOR_DISPLAY = 1

  attr_reader :board

  def display_board(board)
    @board = board
  end

  def display_move(move)
    @next_move = move
  end

  def ask_for_move
    if has_move?
      return pop_move
    end
    next_move
  end

  def has_move?
    next_move != INVALID_MOVE
  end
  
  private

  attr_reader :next_move

  def pop_move
    popped_move = next_move
    @next_move = INVALID_MOVE
    popped_move
  end
end
