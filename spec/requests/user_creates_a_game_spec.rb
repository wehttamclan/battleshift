require 'rails_helper'


describe 'POST /api/v1/games' do
  context 'to create a game' do
    it 'returns a game with boards' do
      user_1 = create(:user, activated: 1)
      user_2 = create(:user, activated: 1, email: 'opp@email.com')

      headers = { "CONTENT_TYPE" => "application/json",
                  "X-API-Key" => user_1.api_key}

      json_payload = { opponent_email: user_2.email }.to_json

      expect(Game.count).to eq 0

      post '/api/v1/games', params: json_payload, headers: headers
      game = JSON.parse(response.body, symbolize_names: true)

      expect(Game.count).to eq 1
      expect(response).to be_successful
      expect(game).to have_key(:player_1_board)
      expect(game).to have_key(:current_turn)
      expect(game[:player_1_board]).to have_key(:rows)
    end
  end
end