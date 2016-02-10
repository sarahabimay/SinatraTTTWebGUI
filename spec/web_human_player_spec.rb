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
end
