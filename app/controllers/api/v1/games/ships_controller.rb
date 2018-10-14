class Api::V1::Games::ShipsController < ApiController
  def create
    game = Game.find(params[:game_id])
    
    board_1 = game.player_1_board
    board_2 = game.player_2_board
    
    ship = Ship.new(ship_params[:ship_size])
    
    ship.place(ship_params[:start_space], ship_params[:end_space])
    ShipPlacer.new(board:board_1, ship:ship, start_space:ship.start_space, end_space:ship.end_space).run
    

  end

  private
  def ship_params
    params.require(:ship).permit(:ship_size, :start_space, :end_space)
  end
end