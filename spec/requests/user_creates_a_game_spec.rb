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
      
      expect(Game.count).to eq 1
    end
  end
end