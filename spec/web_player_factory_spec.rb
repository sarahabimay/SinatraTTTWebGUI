require "web_player_factory"
require "web_human_player"

RSpec.describe WebPlayerFactory do
  let(:human_v_human) { "HVH" }

  it "creates two WebHumanPlayers" do
    display = double("WebDisplay")
    player_factory  = WebPlayerFactory.new(display)
    players = player_factory.get_players_for_game_type(human_v_human)
    expect(players[TicTacToe::Mark::X]).to be_instance_of(WebHumanPlayer)
    expect(players[TicTacToe::Mark::O]).to be_instance_of(WebHumanPlayer)
  end
end
