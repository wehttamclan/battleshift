require 'securerandom'

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
  player_1_board: player_1_board,
  player_2_board: player_2_board,
  player_1_turns: 0,
  player_2_turns: 0,
  current_turn: "player_1",
  player_1_api_key: user_1.api_key,
  player_2_api_key: user_2.api_key
}

game = Game.new(game_attributes)
game.save!
