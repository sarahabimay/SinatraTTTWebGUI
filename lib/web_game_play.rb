require "tictactoe/game"
require "tictactoe/board"
require "web_game_create"

class WebGamePlay
  attr_reader :web_game

  def initialize(params, web_game)
    @next_move = params["position"]
    @web_game = web_game
    @display = web_game.display
    @game = web_game.game
    play(params)
  end

  private

  attr_reader :next_move, :display, :game

  def play(params)
    play_move(params)
    display.display_result
  end

  def play_move(params)
    position = params["position"]
    if !position.nil?
      display.display_move(position)
      game.play_turns
    end
  end
end
