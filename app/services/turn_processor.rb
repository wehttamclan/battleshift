class TurnProcessor
  attr_reader :hit, :status
  def initialize(game, target, key=nil)
    @game   = game
    @target = target
    @messages = []
    @key = key
    @hit = 0
    @status = 200
  end

  def run!
    begin
      attack # if valid_move?
      game.save!
    rescue InvalidAttack => e
      @messages << e.message
    end
  end

  def message
    @messages.join(" ")
  end

  def process_turn
    if game.game_over == false
      if player_1_move? || player_2_move?
        if shot_on_board?
          run!
          # make_move
          if did_it_sink == "Battleship sunk. Game over."
            game.game_over = true
            user = User.find_by_api_key(key)
            game.update_attribute(:winner, user.email)
            game.save!
            # render json: game, message: "#{@turn_processor.message}#{did_it_sink}", winner: game.winner
          # else
            # render json: game, message: "#{@turn_processor.message}#{did_it_sink}"
          end
        else
          @status = 400
          @messages << "Invalid coordinates."
          # render json: game, status: 400, message: "Invalid coordinates."
        end
      else
        @status = 400
        @messages << "Invalid move. It's your opponent's turn"
        # render json: game, status: 400, message: "Invalid move. It's your opponent's turn"
      end
    else
      @status = 400
      @messages << "Invalid move. Game over."
      # render json: game, status: 400, message: "Invalid move. Game over.", winner: game.winner
    end
  end

  # def make_move
  #   @turn_processor = TurnProcessor.new(game, key)
  #   @turn_processor.run!
  # end

  def player_1_move?
    game.current_turn == "player_1" && key == game.player_1_api_key
  end

  def player_2_move?
    game.current_turn == "player_2" && key == game.player_2_api_key
  end

  def shot_on_board?
    if game.current_turn == "player_1"
      game_coords = game.player_2_board.all_coordinates
      game_coords.include?(target)
    elsif game.current_turn == "player_2"
      game_coords = game.player_1_board.all_coordinates
      game_coords.include?(target)
    end
  end

  # CHECK BOARD STATUS, maybe move to board model
  def did_it_sink
    if hit == 1
      if game.current_turn == "player_1"
        board = game.player_1_board
        board_checking(board)
      elsif game.current_turn == "player_2"
        board = game.player_2_board
        board_checking(board)
      end
    end
  end

  def board_checking(board)
    if board.ships.all? { |ship| ship.all? { |coord| board.contains_hit?(coord) } }
      @messages << "Battleship sunk. Game over."
      "Battleship sunk. Game over."
    elsif board.ships.any? { |ship| ship.all? { |coord| board.contains_hit?(coord) } }
      @messages << "Battleship sunk."
    end
  end


  private
  attr_reader :game, :target, :key

  def attack_opponent(opposition)
    result = Shooter.fire!(board: opposition.board, target: target)
    @messages << "Your shot resulted in a #{result}."
    game.player_1_turns += 1
    @hit = 1 if result == "Hit"
  end

  def ai_attack_back
    result = AiSpaceSelector.new(player.board).fire!
    @messages << "The computer's shot resulted in a #{result}."
    game.player_2_turns += 1
    @hit = 1 if result == "Hit"
  end

  def attack
    if game.current_turn == "player_1"
      attack_opponent(opponent)
    elsif game.current_turn == "player_2"
      attack_opponent(player)
    end
    next_turn
  end

  def next_turn
    if game.current_turn == "player_1"
      game.current_turn = "player_2"
    elsif game.current_turn == "player_2"
      game.current_turn = "player_1"
    end
  end

  def player
    Player.new(game.player_1_board)
  end

  def opponent
    Player.new(game.player_2_board)
  end

end
