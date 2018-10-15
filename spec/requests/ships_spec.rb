require 'rails_helper'

describe "POST /api/v1/games/:id/ships" do
    let(:player_1_board)   { Board.new(4) }
    let(:player_2_board)   { Board.new(4) }
    let(:sm_ship) { Ship.new(2) }
    let(:game)    {
      create(:game,
        player_1_board: player_1_board,
        player_2_board: player_2_board,
        current_turn: 'player_1'
      )
    }
    it 'returns a game with ships placed' do

    player_1_board = Board.new(4)
    player_2_board = Board.new(4)
    sm_ship = Ship.new(2)
    md_ship = Ship.new(3)

    ShipPlacer.new(board: player_1_board,
                   ship: sm_ship,
                   start_space: "A1",
                   end_space: "A2"
                  ).run

    ShipPlacer.new(board: player_1_board,
                   ship: md_ship,
                   start_space: "B1",
                   end_space: "D1"
                  ).run

    ShipPlacer.new(board: player_2_board,
                   ship: sm_ship.dup,
                   start_space: "A1",
                   end_space: "A2"
                  ).run

    ShipPlacer.new(board: player_2_board,
                   ship: md_ship.dup,
                   start_space: "B1",
                   end_space: "D1"
                  ).run

    game_attributes = {
                    player_1_board: player_1_board,
                    player_2_board: player_2_board,
                    player_1_turns: 0,
                    player_2_turns: 0,
                    current_turn: "player_1"
                  }

    game = Game.new(game_attributes)
    game.save!
    id = game.id

    post "/api/v1/games/#{id}/ships"

    actual  = JSON.parse(response.body, symbolize_names: true)
    expected = Game.last

    expect(response).to be_success
    expect(actual[:id]).to eq(expected.id)
    expect(actual[:current_turn]).to eq(expected.current_turn)
    expect(actual[:player_1_board][:rows].count).to eq(4)
    expect(actual[:player_2_board][:rows].count).to eq(4)
    expect(actual[:player_1_board][:rows][0][:name]).to eq("row_a")
    expect(actual[:player_1_board][:rows][3][:data][0][:coordinates]).to eq("D1")
    expect(actual[:player_1_board][:rows][3][:data][0][:coordinates]).to eq("D1")
    expect(actual[:player_1_board][:rows][3][:data][0][:status]).to eq("Not Attacked")
  end
end