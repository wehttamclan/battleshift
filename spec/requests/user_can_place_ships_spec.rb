require 'rails_helper'


describe 'POST /api/v1/games/:id/ships' do
  context 'to place a ship' do
    it 'and return messages' do
      user_1 = create(:user, activated: 1)
      user_2 = create(:user, activated: 1, email: 'opp@email.com')
      
      game = create(:game)

      headers = { "CONTENT_TYPE" => "application/json",
                  "X-API-Key" => user_1.api_key}

      ship_1_payload = {ship_size: 3,
                        start_space: "A1",
                        end_space: "A3"}.to_json

      post "/api/v1/games/#{game.id}/ships", params: ship_1_payload, headers: headers
      
      game = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 204
      expect(game).to have_key(:player_1_board)
      expect(game).to have_key(:current_turn)
    end
  end
end