require "tictactoe/mark"
require "web_game_create"

RSpec.describe WebGameCreate do
  let(:three_by_three) { "THREE_BY_THREE" }
  let(:human_v_human) { "HVH" }
  let(:params) { { "dimension"  => three_by_three, "game_type" => human_v_human } } 

  it "creates a new game based on options" do
    session_stub = {} 
    player_factory = instance_spy(WebPlayerFactory) 
    display = instance_spy(WebDisplay)
    player1 = instance_spy(WebHumanPlayer) 
    player2 = instance_spy(WebHumanPlayer) 
    allow(player_factory).to receive(:get_players_for_game_type).and_return(Hash[TicTacToe::Mark::X, player1, TicTacToe::Mark::O, player2])
    allow(display).to receive(:display_board)
    web_game = WebGameCreate.new(player_factory, display)
    web_game.play(params, session_stub)
    expect(web_game.ready_to_play?).to eq(true)
  end

  it "plays a move in a specified position" do 
    session_stub = {} 
    player_factory = instance_spy(WebPlayerFactory) 
    display = instance_spy(WebDisplay)
    player1 = instance_spy(WebHumanPlayer) 
    player2 = instance_spy(WebHumanPlayer) 
    allow(player_factory).to receive(:get_players_for_game_type).and_return(Hash[TicTacToe::Mark::X, player1, TicTacToe::Mark::O, player2])
    allow(player1).to receive(:is_ready?).and_return(true)
    allow(player2).to receive(:is_ready?).and_return(false)
    allow(player1).to receive(:get_next_move).and_return(1)
    web_game = WebGameCreate.new(player_factory, display)
    web_game.play(params, session_stub)
    expect(display).to receive(:display_move).with(1)
    web_game.play_move(1, session_stub)
  end

  it "updates session object with board state after a move" do
    session_stub = {} 
    player_factory = instance_spy(WebPlayerFactory) 
    display = instance_spy(WebDisplay)
    player1 = instance_spy(WebHumanPlayer) 
    player2 = instance_spy(WebHumanPlayer) 
    allow(player_factory).to receive(:get_players_for_game_type).and_return(Hash[TicTacToe::Mark::X, player1, TicTacToe::Mark::O, player2])
    allow(player1).to receive(:is_ready?).and_return(true)
    allow(player2).to receive(:is_ready?).and_return(false)
    allow(player1).to receive(:get_next_move).and_return(1)
    web_game = WebGameCreate.new(player_factory, display)
    web_game.play(params, session_stub)
    web_game.play_move(1, session_stub)
    expect(session_stub[:board_cells]).to eq(["X", nil, nil, nil, nil, nil, nil, nil, nil])
  end

end
