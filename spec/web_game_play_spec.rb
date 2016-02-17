require "web_game_play"
require "web_game_create"
require "web_player_factory"
require "web_display"

RSpec.describe WebGamePlay do
  let(:web_game_spy) { instance_spy(WebGameCreate) }
  let(:display) { WebDisplay.new }
  let(:three_by_three) { "THREE_BY_THREE" }
  let(:human_v_human) { "HVH" }
  let(:params) { { "dimension"  => three_by_three, "game_type" => human_v_human } }

  it "plays a move" do
    session_stub = {}
    params["position"] = 1
    web_game = WebGamePlay.new(params, WebGameCreate.new(params, WebPlayerFactory.new(display), display))
    expect(display.board_cells).to eq([["X", nil, nil], [nil, nil, nil], [nil, nil, nil]])
  end

  it "tells web_display there is a result" do
    result_board = [["X", "O", "X"], ["X", "O", "O"], ["O", "X", "X"]]
    game_spy = instance_spy(TicTacToe::Game)
    display_spy = instance_spy(WebDisplay)
    allow(web_game_spy).to receive(:game).and_return(game_spy)
    allow(web_game_spy).to receive(:display).and_return(display_spy)
    allow(game_spy).to receive(:play_turns).and_return(result_board)
    expect(display_spy).to receive(:display_result)
    web_game = WebGamePlay.new(params, web_game_spy).web_game
  end
end

