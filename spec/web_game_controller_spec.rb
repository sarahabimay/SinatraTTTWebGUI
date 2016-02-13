require "tictactoe/mark"
require "web_game_controller"

RSpec.describe WebGameController do
  let(:three_by_three) { 3 }
  let(:human_v_human) { "HVH" }

  it "creates a new game based on options" do
    player_factory = instance_spy(WebPlayerFactory) 
    display = instance_spy(WebDisplay)
    player1 = instance_spy(WebHumanPlayer) 
    player2 = instance_spy(WebHumanPlayer) 
    allow(player_factory).to receive(:get_players_for_game_type).and_return(Hash[TicTacToe::Mark::X, player1, TicTacToe::Mark::O, player2])
    allow(display).to receive(:display_board)
    game_controller = WebGameController.new(player_factory, display)
    game_controller.create_game(three_by_three, human_v_human);
    expect(game_controller.ready_to_play?).to eq(true)
  end
end
