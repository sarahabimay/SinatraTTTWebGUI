require "tictactoe/board"
require "web_human_player"
require "web_display"

RSpec.describe WebHumanPlayer do
  it "player provides it's next move" do
    display = instance_spy(WebDisplay)
    board = instance_spy(TicTacToe::Board)
    allow(display).to receive(:ask_for_move).and_return(1)
    human_player = WebHumanPlayer.new(display)
    expect(human_player.get_next_move(board)).to eq(1)
  end

  it "player does not have a next move" do
    display = instance_spy(WebDisplay)
    board = instance_spy(TicTacToe::Board)
    allow(display).to receive(:has_move?).and_return(false)
    human_player = WebHumanPlayer.new(display)
    expect(human_player.is_ready?).to eq(false)
  end
end
