require 'rails_helper'

describe "Api::V1::Shots" do
  context "POST /api/v1/games/:id/shots" do
    let(:user_1) { create(:user) }
    let(:user_2) { create(:user) }
    let(:sm_ship) { Ship.new(2) }
    let(:md_ship) { Ship.new(3) }
    let(:game_1) {create(:game, player_1_id: user_1.id, player_2_id: user_2.id)}

    it 'prevents a player from playing a game they are not a part of' do
      user_3 = create(:user)
      user_3.update(api_key: "5566")

      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => "5566" }
      json_payload = {target: "A1"}.to_json
      post "/api/v1/games/#{game_1.id}/shots", params: json_payload, headers: headers

      error = JSON.parse(response.body, symbolize_names: true)
      expected_messages = "Unauthorized"
      expect(response.status).to eq(401)
      expect(error[:message]).to eq expected_messages
    end

    it "updates the message and board with a hit" do
      user_1.update(api_key: "1234")

      ShipPlacer.new(board: game_1.player_2_board,
                     ship: sm_ship,
                     start_space: "A1",
                     end_space: "A2").run
      game_1.save

      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => "1234" }
      json_payload = {target: "A1"}.to_json
      post "/api/v1/games/#{game_1.id}/shots", params: json_payload, headers: headers

      expect(response).to be_successful

      game = JSON.parse(response.body, symbolize_names: true)

      expected_messages = "Your shot resulted in a Hit."

      player_2_targeted_space = game[:player_2_board][:rows].first[:data].first[:status]

      expect(game[:message]).to eq expected_messages
      expect(player_2_targeted_space).to eq("Hit")
    end

    it "updates the message and board with a miss" do
      user_1.update(api_key: "1234")

      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => "1234" }
      json_payload = {target: "A1"}.to_json

      post "/api/v1/games/#{game_1.id}/shots", params: json_payload, headers: headers

      expect(response).to be_successful

      game = JSON.parse(response.body, symbolize_names: true)

      expected_messages = "Your shot resulted in a Miss."
      player_2_targeted_space = game[:player_2_board][:rows].first[:data].first[:status]


      expect(game[:message]).to eq expected_messages
      expect(player_2_targeted_space).to eq("Miss")
    end

    it "updates the message but not the board with invalid coordinates" do
      user_1.update(api_key: "1234")

      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => "1234" }
      json_payload = {target: "E1"}.to_json
      post "/api/v1/games/#{game_1.id}/shots", params: json_payload, headers: headers

      game = JSON.parse(response.body, symbolize_names: true)
      expect(game[:message]).to eq "Invalid coordinates"
    end

    it 'updates message when its not that players turn' do
      user_1.update(api_key: "1234")
      user_2.update(api_key: "5678")

      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => "1234" }
      json_payload = {target: "A1"}.to_json
      post "/api/v1/games/#{game_1.id}/shots", params: json_payload, headers: headers

      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => "1234" }
      json_payload = {target: "A2"}.to_json
      post "/api/v1/games/#{game_1.id}/shots", params: json_payload, headers: headers

      game = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(400)
      expect(game[:message]).to eq "Invalid move. It's your opponent's turn"

      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => "5678" }
      json_payload = {target: "A1"}.to_json
      post "/api/v1/games/#{game_1.id}/shots", params: json_payload, headers: headers

      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => "5678" }
      json_payload = {target: "A1"}.to_json
      post "/api/v1/games/#{game_1.id}/shots", params: json_payload, headers: headers

      game = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(400)
      expect(game[:message]).to eq "Invalid move. It's your opponent's turn"
    end

    it 'updates message when ship is sunk' do
      user_1.update(api_key: "1234")
      user_2.update(api_key: "5678")

      ShipPlacer.new(board: game_1.player_2_board,
                     ship: sm_ship,
                     start_space: "A1",
                     end_space: "A2").run
      game_1.save

      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => "1234" }
      json_payload = {target: "A1"}.to_json
      post "/api/v1/games/#{game_1.id}/shots", params: json_payload, headers: headers

      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => "5678" }
      json_payload = {target: "A1"}.to_json
      post "/api/v1/games/#{game_1.id}/shots", params: json_payload, headers: headers

      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => "1234" }
      json_payload = {target: "A2"}.to_json
      post "/api/v1/games/#{game_1.id}/shots", params: json_payload, headers: headers

      game = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      expect(game[:message]).to eq "Your shot resulted in a Hit. Battleship sunk."
    end

    it 'updates message when both ships sunk' do
      user_1.update(api_key: "1234")
      user_2.update(api_key: "5678")

      ShipPlacer.new(board: game_1.player_2_board,
                     ship: sm_ship,
                     start_space: "A1",
                     end_space: "A2").run

     ShipPlacer.new(board: game_1.player_2_board,
                    ship: md_ship,
                    start_space: "B1",
                    end_space: "D1").run
      game_1.save

      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => "1234" }
      json_payload = {target: "A1"}.to_json
      post "/api/v1/games/#{game_1.id}/shots", params: json_payload, headers: headers

      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => "5678" }
      json_payload = {target: "A1"}.to_json
      post "/api/v1/games/#{game_1.id}/shots", params: json_payload, headers: headers

      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => "1234" }
      json_payload = {target: "A2"}.to_json
      post "/api/v1/games/#{game_1.id}/shots", params: json_payload, headers: headers

      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => "5678" }
      json_payload = {target: "B1"}.to_json
      post "/api/v1/games/#{game_1.id}/shots", params: json_payload, headers: headers

      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => "1234" }
      json_payload = {target: "B1"}.to_json
      post "/api/v1/games/#{game_1.id}/shots", params: json_payload, headers: headers

      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => "5678" }
      json_payload = {target: "B2"}.to_json
      post "/api/v1/games/#{game_1.id}/shots", params: json_payload, headers: headers

      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => "1234" }
      json_payload = {target: "C1"}.to_json
      post "/api/v1/games/#{game_1.id}/shots", params: json_payload, headers: headers

      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => "5678" }
      json_payload = {target: "B3"}.to_json
      post "/api/v1/games/#{game_1.id}/shots", params: json_payload, headers: headers

      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => "1234" }
      json_payload = {target: "D1"}.to_json
      post "/api/v1/games/#{game_1.id}/shots", params: json_payload, headers: headers

      game = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      expect(game[:message]).to eq "Your shot resulted in a Hit. Battleship sunk. Game over."

      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => "5678" }
      json_payload = {target: "B4"}.to_json
      post "/api/v1/games/#{game_1.id}/shots", params: json_payload, headers: headers

      game = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(400)
      expect(game[:message]).to eq "Invalid move. Game over."
    end
  end
end
