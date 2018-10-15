class Api::V1::Games::ShipsController < ApiController
  def create
    game = Game.find(params[:game_id])

    if request.headers["X-API-Key"] == game.player_1_api_key
      board = game.player_1_board
    elsif request.headers["X-API-Key"] == game.player_2_api_key
      board = game.player_2_board
    end

    ship = Ship.new(ship_params[:ship_size])

    ship.place(ship_params[:start_space], ship_params[:end_space])
    ShipPlacer.new(board:board, ship:ship, start_space:ship.start_space, end_space:ship.end_space).run
    board.ship_math(ship_params[:ship_size])
    option = " with a size of #{board.ship_places}"
    game.messages=("Successfully placed ship with a size of #{ship_params[:ship_size]}. You have #{board.ship_count} ship(s) to place#{option if board.ship_count > 0 }.")


    game.save

    render json: game
  end

  private
  def ship_params
    params.require(:ship).permit(:ship_size, :start_space, :end_space)
  end
end
