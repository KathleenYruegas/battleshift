require 'rails_helper'

describe "Api::V1::Ships" do
  context "POST /api/v1/games/:id/ships" do
    let(:user_1) { create(:user) }
    let(:user_2) { create(:user) }
    let(:sm_ships) { Ship.new(2) }
    let(:game) { create(:game, player_1_id: user_1.id, player_2_id: user_2.id) }

    it "can find a game and place ships" do
    user_1.update(api_key: "1234")
    user_2.update(api_key: "5678")
    game.save

    headers = { "CONTENT-TYPE" => "application/json", "X-API-Key" => "1234" }
    ship_json_payload =  { ship_size: 3,
                     start_space: "A1",
                     end_space: "A3"
                    }.to_json

    post "/api/v1/games/#{game.id}/ships", params: ship_json_payload, headers: headers

    expect(response).to be_successful

    game = JSON.parse(response.body, symbolize_names: true)

    message = "Successfully placed ship with a size of 3. You have 1 ship(s) to place with a size of 2."

    expect(game[:message]).to eq(message)
    end
  end
end
