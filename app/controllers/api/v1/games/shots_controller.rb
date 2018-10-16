module Api
  module V1
    module Games
      class ShotsController < ApiController
        def create
          @game = Game.find(params[:game_id])

          if player_1_move? || player_2_move?
              if shot_on_board?
                make_move
              else
                render json: @game, status: 400, message: "Invalid coordinates"
              end
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

        def player_1_move?
          @game.current_turn == "player_1" && request.headers["X-API-KEY"] == @game.player_1_api_key
        end

        def player_2_move?
          @game.current_turn == "player_2" && request.headers["X-API-KEY"] == @game.player_2_api_key
        end

        def shot_on_board?
          if @game.current_turn == "player_1"
            game_coords = @game.player_2_board.all_coordinates
            game_coords.include?(params[:shot][:target])
          elsif @game.current_turn == "player_2"
            game_coords = @game.player_1_board.all_coordinates
            game_coords.include?(params[:shot][:target])
          end
        end
      end
    end
  end
end
