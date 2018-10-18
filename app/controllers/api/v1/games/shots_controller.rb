module Api
  module V1
    module Games
      class ShotsController < ApiController
        before_action :validate_user
        def create
          target  = params[:shot][:target]
          api_key = request.headers["X-API-KEY"]
          turn_processor = TurnProcessor.new(game, target, api_key)
          turn_processor.process_turn

          render json: game, status: turn_processor.status, message: turn_processor.message
        end

        private

        def game
          Game.find(params[:game_id])
        end

        def validate_user
          unless valid_user?
            render json: game, status: 401 , message: "Unauthorized"
          end
        end

        def valid_user?
          incoming_api = request.headers["X-API-KEY"]
          game.player_1_api_key == incoming_api || game.player_2_api_key == incoming_api
        end
      end
    end
  end
end
