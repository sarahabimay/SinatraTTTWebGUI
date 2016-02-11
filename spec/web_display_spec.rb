require "web_display"

RSpec.describe WebDisplay do
  let(:invalid_move) { -1 }
  let(:three_by_three) { 3 }

  it "has a board for display" do
    board = double("Board")
    allow(board).to receive(:board_size).and_return(three_by_three*three_by_three)
    display = WebDisplay.new
    display.display_board(board)
    expect(display.board.board_size).to eq(three_by_three*three_by_three)
  end

  it "has a new move available" do
    display = WebDisplay.new
    display.display_move(1)
    expect(display.ask_for_move).to eq(1)
  end

  it "no longer has a move once it has been asked  for" do
    display = WebDisplay.new
    display.display_move(1)
    display.ask_for_move
    expect(display.ask_for_move).to be(invalid_move)
  end
end
