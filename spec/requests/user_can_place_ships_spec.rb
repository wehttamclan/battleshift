require 'rails_helper'

describe 'POST /api/v1/games/:id/ships' do
  context 'to place a ship' do
    before :each do
      @user_1 = create(:user, activated: 1, email: '1_@email.com')
      @user_2 = create(:user, activated: 1, email: '2_@email.com')
      @game = create(:game, player_1_api_key: @user_1.api_key, player_2_api_key: @user_2.api_key)
    end
    
    it 'and return messages' do
      headers = { "CONTENT_TYPE" => "application/json",
                  "X-API-Key" => @user_1.api_key}

      ship_1_payload = {ship_size: 3,
                        start_space: "A1",
                        end_space: "A3"}.to_json

      post "/api/v1/games/#{@game.id}/ships", params: ship_1_payload, headers: headers
      
      game = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(game).to have_key(:player_1_board)
      expect(game).to have_key(:current_turn)
    end
  end
end