require "tictactoe/mark"
require "tictactoe/board"
require "tictactoe/board_options"
require "tictactoe/game_type_options"
require "web_game_create"
require "web_display"
require "web_player_factory"

RSpec.describe WebGameCreate do
  let(:three_by_three) { "THREE_BY_THREE" }
  let(:dimension_3) { 3 }
  let(:human_v_human) { "HVH" }
  let(:params) { { "dimension"  => three_by_three, "game_type" => human_v_human } }
  let(:player_factory) { instance_spy(WebPlayerFactory) }
  let(:display) { instance_spy(WebDisplay) }
  let(:player1) { instance_spy(WebHumanPlayer) }
  let(:player2) { instance_spy(WebHumanPlayer) }

  it "creates a new game based on options" do
    session_stub = {}
    set_player_ready_state
    allow(display).to receive(:board).and_return(TicTacToe::Board.new(dimension_3))
    allow(display).to receive(:display_board)
    web_game = WebGameCreate.new(params, session_stub, player_factory, display)
    web_game.play(params)
    expect(web_game.ready_to_play?).to eq(true)
  end

  it "plays a move in a specified position" do
    session_stub = {}
    set_player_ready_state(player1_is_ready: true)
    allow(player1).to receive(:get_next_move).and_return(1)
    allow(display).to receive(:board).and_return(TicTacToe::Board.new(dimension_3))
    web_game = WebGameCreate.new(params, session_stub, player_factory, display)
    expect(display).to receive(:display_move).with(1)
    params["position"] = 1
    web_game.play(params)
  end

  it "updates session object with board state after a move" do
    session_stub = {}
    set_player_ready_state(player1_is_ready: true)
    allow(player1).to receive(:get_next_move).and_return(1)
    allow(display).to receive(:board).and_return(TicTacToe::Board.new(dimension_3))
    web_game = WebGameCreate.new(params, session_stub, player_factory, display)
    params["position"] = 1
    web_game.play(params)
    expect(session_stub[:board_cells]).to eq(["X", nil, nil, nil, nil, nil, nil, nil, nil])
  end

  it "tells web_display game is over" do
    session_stub = { :board_cells => ["X", "O", "X", "X", "O", "O", "O", "X", "X"] }
    board = TicTacToe::Board.new(dimension_3, session_stub[:board_cells].each_slice(3).to_a)
    allow(display).to receive(:board).and_return(board)
    expect(display).to receive(:set_game_state).with(is_in_play: false)
    web_game = WebGameCreate.new(params, session_stub, player_factory, display)
    params["position"] = 1
    web_game.play(params)
  end

  it "tells web_display what the winning mark is " do
    session_stub = { :board_cells => ["X", "X", "X", "O", "O", 6, 7, 8, 9] }
    board = TicTacToe::Board.new(dimension_3, session_stub[:board_cells].each_slice(3).to_a)
    allow(display).to receive(:board).and_return(board)
    allow(display).to receive(:set_game_state).with(is_in_play: false)
    expect(display).to receive(:display_win)
    web_game = WebGameCreate.new(params, session_stub, player_factory, display)
    params["position"] = 1
    web_game.play(params)
  end

  it "tells web_display there is a draw " do
    session_stub = { :board_cells => ["X", "O", "X", "X", "O", "O", "O", "X", "X"] }
    board = TicTacToe::Board.new(dimension_3, session_stub[:board_cells].each_slice(3).to_a)
    allow(display).to receive(:board).and_return(board)
    allow(display).to receive(:set_game_state).with(is_in_play: false)
    web_game = WebGameCreate.new(params, session_stub, player_factory, display)
    params["position"] = 1
    web_game.play(params)
    expect(web_game.send(:winning_mark_found?)).to be(false)
  end

  def set_player_ready_state(player1_is_ready: false, player2_is_ready: false)
    allow(player_factory).to receive(:get_players_for_game_type).and_return(Hash[TicTacToe::Mark::X, player1, TicTacToe::Mark::O, player2])
    allow(player1).to receive(:is_ready?).and_return(player1_is_ready)
    allow(player2).to receive(:is_ready?).and_return(player2_is_ready)
  end
end
