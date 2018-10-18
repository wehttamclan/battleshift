require 'rails_helper'

RSpec.describe TurnProcessor, type: :model do
  before(:each) do
    player_1_board = Board.new(4)
    player_2_board = Board.new(4)

    sm_ship = Ship.new(2)
    md_ship = Ship.new(3)

    # Place Player 1 ships
    ShipPlacer.new(board: player_1_board,
                   ship: sm_ship,
                   start_space: "A1",
                   end_space: "A2").run

    ShipPlacer.new(board: player_1_board,
                   ship: md_ship,
                   start_space: "B1",
                   end_space: "D1").run

    # Place Player 2 ships
    ShipPlacer.new(board: player_2_board,
                   ship: sm_ship.dup,
                   start_space: "A1",
                   end_space: "A2").run

    ShipPlacer.new(board: player_2_board,
                   ship: md_ship.dup,
                   start_space: "B1",
                   end_space: "D1").run

    user_1 = User.create!(name: "Josiah Bartlet",
                          email: "jbarlet@example.com",
                          address: "1600 Pennsylvania Ave NW, Washington, DC 20500",
                          password: "12345",
                          activated: "active"
                        )

    user_2 = User.create!(name: "Bosiah Jartlet",
                          email: "bjarlet@example.com",
                          address: "1600 Chennsylvania Ave NW, Washington, DC 20501",
                          password: "12345",
                          activated: "active"
                        )

    user_1.update(api_key: "player_1")
    user_2.update(api_key: "player_2")

    game_attributes = {
      id: 304,
      player_1_board: player_1_board,
      player_2_board: player_2_board,
      player_1_turns: 0,
      player_2_turns: 0,
      current_turn: "player_1",
      player_1_api_key: user_1.api_key,
      player_2_api_key: user_2.api_key
    }

    @game = Game.new(game_attributes)
    @game.save!
  end
  it "Should set status to 400 if wrong player makes moves" do
    tp = TurnProcessor.new(@game, "D2", @game.player_2_api_key)

    tp.process_turn

    expect(tp.status).to eq(400)
    expect(tp.message).to eq("Invalid move. It's your opponent's turn")
  end
  it "Should set status to 400 if game is over" do
    @game.game_over = true

    tp = TurnProcessor.new(@game, "D2", @game.player_1_api_key)

    tp.process_turn

    expect(tp.status).to eq(400)
    expect(tp.message).to eq("Invalid move. Game over.")
  end
  it "Should return false for did_it_sink" do
    tp = TurnProcessor.new(@game, "A1", @game.player_1_api_key)

    tp.process_turn

    expect(tp.message).to eq("Your shot resulted in a Hit.")
  end
  it "should let player 2 attack opponent" do
    @game.current_turn = "player_2"
    tp = TurnProcessor.new(@game, "A1", @game.player_2_api_key)

    tp.process_turn

    expect(tp.message).to eq("Your shot resulted in a Hit.")
  end
  it "should return nothing if board didn't sink" do
    tp = TurnProcessor.new(@game, "A1", @game.player_1_api_key)
    expect(tp.board_checking(@game.player_2_board)).to eq(nil)
  end
end
