module Api
  module V1
    module Games
      class ShotsController < ApiController

        def create
          # IT CAN'T WORK WITH INACTIVE PLAYERS
          # NEEDS 401 error IF API IS INVALID
          # NEEDS 401 error IF GAME IS NOT YOURS
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

      end
    end
  end
end
