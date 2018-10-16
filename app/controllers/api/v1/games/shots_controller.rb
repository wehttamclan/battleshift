module Api
  module V1
    module Games
      class ShotsController < ApiController
        def create
          # IT CAN'T WORK WITH INACTIVE PLAYERS
          # NEEDS TO PLAY WITH COMPUTER
          # NEEDS 401 error IF API IS INVALID
          # NEEDS 401 error IF GAME IS NOT YOURS
          @game = Game.find(params[:game_id])
          if @game.game_over == false
            if player_1_move? || player_2_move?
              if shot_on_board?
                make_move
                if did_it_sink == " Battleship sunk. Game over."
                  @game.game_over = true
                  @game.winner = User.find_by_api_key(request.headers["X-API-KEY"]).email
                  @game.save!
                  render json: @game, message: "#{@turn_processor.message}#{did_it_sink}", winner: @game.winner
                else
                  render json: @game, message: "#{@turn_processor.message}#{did_it_sink}"
                end
              else
                render json: @game, status: 400, message: "Invalid coordinates"
              end
            else
              render json: @game, status: 400, message: "Invalid move. It's your opponent's turn"
            end
          else
            render json: @game, status: 400, message: "Invalid move. Game over.", winner: @game.winner
          end
        end

        private

        def make_move
          @turn_processor = TurnProcessor.new(@game, params[:shot][:target])
          @turn_processor.run!
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

        def did_it_sink
          if @turn_processor.hit == 1
            if @game.current_turn == "player_1"
              board = @game.player_1_board
              board_checking(board)
            elsif @game.current_turn == "player_2"
              board = @game.player_2_board
              board_checking(board)
            end
          end
        end

        def board_checking(board)
          if board.ships.all? { |ship| ship.all? { |coord| board.contains_hit?(coord) } }
            " Battleship sunk. Game over."
          elsif board.ships.any? { |ship| ship.all? { |coord| board.contains_hit?(coord) } }
            " Battleship sunk."
          end
        end
      end
    end
  end
end
