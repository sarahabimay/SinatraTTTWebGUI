require "tictactoe/player"

class WebHumanPlayer
  include Player

  def initialize(display)
    @display = display
  end

  def get_next_move(board)
    display.ask_for_move
  end

  private

  attr_reader :display
end
