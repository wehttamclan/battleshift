module Api
  module V1
    class GamesController < ActionController::API
      def show
        game = Game.find_by_id(params[:id])
        if game
          render json: game
        else
          render status: 400
        end
      end

      def create
        api_key = request.headers["X-API-Key"]
        opponent_email = params[:opponent_email]

        user = User.find_by_api_key(api_key)
        
        game_attributes = {
          player_1_board: Board.new(4),
          player_2_board: Board.new(4)
        }

        render json: Game.create(game_attributes)
      end

    end
  end
end
