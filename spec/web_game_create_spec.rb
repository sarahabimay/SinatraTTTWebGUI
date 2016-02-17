require "tictactoe/mark"
require "tictactoe/board"
require "tictactoe/board_options"
require "tictactoe/game_type_options"
require "web_game_create"
require "web_game_play"
require "web_display"
require "web_player_factory"

RSpec.describe WebGameCreate do
  let(:dimension_3) { 3 }
  let(:three_by_three) { "THREE_BY_THREE" }
  let(:human_v_human) { "HVH" }
  let(:params) { { "dimension"  => three_by_three, "game_type" => human_v_human } }
  let(:player_factory_spy) { instance_spy(WebPlayerFactory) }
  let(:display) { instance_spy(WebDisplay) }
  let(:player1) { instance_spy(WebHumanPlayer) }
  let(:player2) { instance_spy(WebHumanPlayer) }

  it "creates a new game based on options" do
    set_player_ready_state
    allow(display).to receive(:board).and_return(TicTacToe::Board.new(dimension_3))
    allow(display).to receive(:display_board)
    web_game = WebGameCreate.new(params, player_factory_spy, display)
    expect(web_game.ready_to_play?).to eq(true)
  end

  it "creates a new game using existing board" do
    set_player_ready_state
    row1 = ["X", "O", "X"]
    row2 = [nil, nil, nil]
    row3 = [nil, nil, nil]
    board_cells = [row1, row2, row3]
    params["board_cells"] = board_cells
    board = TicTacToe::Board.new(dimension_3, board_cells)
    allow(display).to receive(:board).and_return(board)
    web_game = WebGameCreate.new(params, player_factory_spy, display)
    allow(display).to receive(:display_board).with(web_game.game.board)
    expect(display.board.board_cells).to eq(board_cells)
  end

  def set_player_ready_state(player1_is_ready: false, player2_is_ready: false)
    allow(player_factory_spy).to receive(:get_players_for_game_type).and_return(Hash[TicTacToe::Mark::X, player1, TicTacToe::Mark::O, player2])
    allow(player1).to receive(:is_ready?).and_return(player1_is_ready)
    allow(player2).to receive(:is_ready?).and_return(player2_is_ready)
  end
end
