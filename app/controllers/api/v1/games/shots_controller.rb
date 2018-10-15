module Api
  module V1
    module Games
      class ShotsController < ApiController
        def create
          game = Game.find(params[:game_id])

          if game.current_turn == "player_1" && request.headers["X-API-KEY"] == game.player_1_api_key
            turn_processor = TurnProcessor.new(game, params[:shot][:target])
            turn_processor.run!
            message = turn_processor.message
            render json: game, message: message
          elsif game.current_turn == "player_2" && request.headers["X-API-KEY"] == game.player_2_api_key
            turn_processor = TurnProcessor.new(game, params[:shot][:target])
            turn_processor.run!
            message = turn_processor.message
            render json: game, message: message
          else
            message = "Invalid move. It's your opponent's turn"
            render json: game, status: 400, message: message
          end
        end
      end
    end
  end
end
