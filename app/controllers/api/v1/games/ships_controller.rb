class Api::V1::Games::ShipsController < ApiController
  def create
    @game = Game.find(params[:game_id])
    @ship = Ship.new(ship_params[:ship_size])

    place_ship

    @board.ship_math(ship_params[:ship_size])

    @game.save

    render json: @game, message: ship_message
  end

  private

  def ship_params
    params.require(:ship).permit(:ship_size, :start_space, :end_space)
  end

  def board_picker
    if request.headers["X-API-Key"] == @game.player_1_api_key
      @board = @game.player_1_board
    elsif request.headers["X-API-Key"] == @game.player_2_api_key
      @board = @game.player_2_board
    end
  end

  def place_ship
    @ship.place(ship_params[:start_space], ship_params[:end_space])
    board_picker
    
    ShipPlacer.new( board:       @board,
                    ship:        @ship,
                    start_space: @ship.start_space,
                    end_space:   @ship.end_space
                  ).run
  end

  def ship_message
    option = " with a size of #{@board.ship_places}"
    "Successfully placed ship with a size of #{ship_params[:ship_size]}. You have #{@board.ship_count} ship(s) to place#{option if @board.ship_count > 0 }."
  end
end
