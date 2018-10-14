
player_1_board = Board.new(4)
player_2_board = Board.new(4)

sm_ship = Ship.new(2)
md_ship = Ship.new(3)

user_1 = User.create!(name: "Josiah Bartlet", email: ENV["BATTLESHIFT_EMAIL"], address: "1600 Pennsylvania Ave NW, Washington, DC 20500", password: 'test', api_key: ENV["BATTLESHIFT_API_KEY"])
user_2 = User.create!(name: "Billy Bob", email: ENV["BATTLESHIFT_OPPONENT_EMAIL"], address: "1600 Pennsylvania Ave NW, Washington, DC 20500", password: 'test', api_key: ENV["BATTLESHIFT_OPPONENT_API_KEY"])

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

game_attributes = {
  player_1_board: player_1_board,
  player_2_board: player_2_board,
  player_1_turns: 0,
  player_2_turns: 0,
  current_turn: "challenger",
  player_1: user_1.id,
  player_2: user_2.id
}

game = Game.new(game_attributes)
game.save!
