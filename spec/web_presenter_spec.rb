require "web_presenter"

RSpec.describe WebPresenter do
  let(:three_by_three) { 3 }
  let(:three_by_three_description) { "THREE_BY_THREE" }
  let(:human_v_human) { "HVH" }
  let(:params) { { "dimension"  => three_by_three_description, "game_type" => human_v_human } } 
  let(:display) { WebDisplay.new }
  let(:web_game) { web_game = WebGameCreate.new(WebPlayerFactory.new(display), display) }

  it "has game_type for the game_layout.erb view" do
    session_stub = {}
    web_game.play(params, session_stub)
    presenter = WebPresenter.new(web_game)
    expect(presenter.game_type).to eq(human_v_human)
  end

  it "game board has 'dimension' of 3 for the game_layout.erb view" do
    session_stub = {}
    web_game.play(params, session_stub)
    presenter = WebPresenter.new(web_game)
    expect(presenter.board_dimension).to eq(three_by_three)
  end

  it "game board's dimension description for the game_layout.erb view" do
    session_stub = {}
    web_game.play(params, session_stub)
    presenter = WebPresenter.new(web_game)
    expect(presenter.dimension_description).to eq(three_by_three_description)
  end

  it "has all dimensions for game_options.erb view" do
    session_stub = {}
    web_game.play(params, session_stub)
    presenter = WebPresenter.new(web_game)
    expect(presenter.all_dimensions).to eq({ three_by_three_description => three_by_three })
  end

  it "has all game_types for game_options.erb view" do
    session_stub = {}
    web_game.play(params, session_stub)
    presenter = WebPresenter.new(web_game)
    expect(presenter.all_game_types).to eq({"HVH"=>"Human Vs Human", "HVB"=>"Human Vs Easy AI", "BVH"=>"Easy AI Vs Human"})
  end

  it "gets empty board_cells for display" do
    session_stub = {}
    web_game.play(params, session_stub)
    presenter = WebPresenter.new(web_game)
    expect(presenter.board_cells).to eq([ ["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]])
  end
end
