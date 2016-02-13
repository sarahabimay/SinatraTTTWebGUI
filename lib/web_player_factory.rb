require "tictactoe/mark"
require "web_human_player"

class WebPlayerFactory
  def initialize(display)
    @display = display
  end

  def get_players_for_game_type(game_type)
    Hash[TicTacToe::Mark::X, WebHumanPlayer.new(display), TicTacToe::Mark::O, WebHumanPlayer.new(display)]
  end

  private

  attr_reader :display
end
