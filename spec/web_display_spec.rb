require "web_display"

RSpec.describe WebDisplay do
  let(:three_by_three) { 3 }
  let(:display) { WebDisplay.new }
  let(:x_win_announcement) { "Player X is the Winner!" }
  let(:draw_announcement) { "Game Over! The game is a Draw!" }

  it "has a board for display" do
    board = double("Board")
    allow(board).to receive(:board_size).and_return(three_by_three*three_by_three)
    display.display_board(board)
    expect(display.board.board_size).to eq(three_by_three*three_by_three)
  end

  it "has a new move available" do
    display.display_move(1)
    expect(display.ask_for_move).to eq(1)
  end

  it "no longer has a move once it has been asked for" do
    display.display_move(1)
    display.ask_for_move
    expect(display.ask_for_move).to be(WebDisplay::INVALID_MOVE)
  end

  it "display_result displays Winning Announcement " do
    row1 = ["X", "X", "X"]
    row2 = ["O", "O", nil]
    row3 = [nil, nil, nil]
    winning_board = [ row1, row2, row3 ]
    board = TicTacToe::Board.new(three_by_three, winning_board)
    display.display_board(board)
    expect(display.display_result).to eq(TicTacToe::Mark::X)
  end

  it "receives winning mark" do
    display.set_game_state(is_in_play: false)
    display.display_win(TicTacToe::Mark::X)
    expect(display.result).to eq(x_win_announcement)
  end

  it "result is a draw" do
    display.set_game_state(is_in_play: false)
    expect(display.result).to eq(draw_announcement)
  end
end
