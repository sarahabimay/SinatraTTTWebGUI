require "tictactoe/board"

class WebDisplay
  INVALID_MOVE = -1
  OFFSET_FOR_DISPLAY = 1
  WIN_ANNOUNCEMENT = "Player XXX is the Winner!"
  DRAW_ANNOUNCEMENT = "Game Over! The game is a Draw!"

  attr_reader :board, :winning_mark, :game_in_play

  def display_board(board)
    @board = board
  end

  def display_move(move)
    @next_move = move
  end

  def display_result
    if(board.is_game_over?)
      set_game_state(is_in_play: false)
      display_win(board.get_winning_mark)
    end
  end

  def display_win(mark)
    @winning_mark = mark
  end

  def board_cells
    board.board_cells if !board.nil?
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

  def set_game_state(is_in_play: true)
    @game_in_play = is_in_play
  end

  def result
    if !game_in_play && !game_in_play.nil?
      if !winning_mark.nil?
        result = announce_win
      else
        result = announce_draw
      end
    end
    result
  end

  private

  attr_reader :next_move

  def pop_move
    popped_move = next_move
    @next_move = INVALID_MOVE
    popped_move
  end

  def announce_win
    @results_message = WIN_ANNOUNCEMENT.gsub("XXX", "#{winning_mark}")
  end

  def announce_draw
    @results_message = DRAW_ANNOUNCEMENT
  end
end
