module Api
  module V1
    module Games
      class ShotsController < ApiController
        def create
          @game = Game.find(params[:game_id])

          if @game.current_turn == "player_1" && request.headers["X-API-KEY"] == @game.player_1_api_key
            make_move
          elsif @game.current_turn == "player_2" && request.headers["X-API-KEY"] == @game.player_2_api_key
            make_move
          else
            render json: @game, status: 400, message: "Invalid move. It's your opponent's turn"
          end
        end

        private

        def make_move
          turn_processor = TurnProcessor.new(@game, params[:shot][:target])
          turn_processor.run!
          render json: @game, message: turn_processor.message
        end
      end
    end
  end
end
