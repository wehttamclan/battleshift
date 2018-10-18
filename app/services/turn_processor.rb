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
    if @game.player_2_api_key != nil
      begin
        attack # if valid_move?
        did_it_sink
        @game.save!
      rescue InvalidAttack => e
        @messages << e.message
      end
    else
      ai_battle
      @game.save!
    end
  end

  def message
    @messages.join(" ")
  end

  def process_turn
    if is_in_game?
      if @game.game_over == false
        if player_1_move? || player_2_move?
          if shot_on_board?
            run!
            set_winner if message == "Your shot resulted in a Hit. Battleship sunk. Game over."
          else
            @status = 400
            @messages << "Invalid coordinates."
          end
        else
          @status = 400
          @messages << "Invalid move. It's your opponent's turn"
        end
      else
        @status = 400
        @messages << "Invalid move. Game over."
      end
    else
      @status = 401
      @messages << "Unauthorized"
    end
  end


  def player_1_move?
    @game.current_turn == "player_1" && key == @game.player_1_api_key
  end

  def player_2_move?
    @game.current_turn == "player_2" && key == @game.player_2_api_key
  end

  def is_in_game?
    @key == @game.player_1_api_key || @key == @game.player_2_api_key
  end

  def shot_on_board?
    if @game.current_turn == "player_1"
      game_coords = @game.player_2_board.all_coordinates
      game_coords.include?(target)
    elsif game.current_turn == "player_2"
      game_coords = @game.player_1_board.all_coordinates
      game_coords.include?(target)
    end
  end

  # CHECK BOARD STATUS, maybe move to board model
  def did_it_sink
    if hit == 1
      if @game.current_turn == "player_1"
        board = game.player_1_board
        board_checking(board)
      elsif @game.current_turn == "player_2"
        board = game.player_2_board
        board_checking(board)
      end
    end
  end

  def board_checking(board)
    ship = board.locate_space(@target).contents
    ship.attack!
    @messages << "Battleship sunk." if ship.is_sunk?
    @messages << "Game over." if board.all_sunk?
  end

  private

  attr_reader :game, :target, :key

  def attack_opponent(opposition)
    result = Shooter.fire!(board: opposition.board, target: target)
    @messages << "Your shot resulted in a #{result}."
    @game.player_1_turns += 1
    @hit = 1 if result == "Hit"
  end

  def ai_attack_back
    result = AiSpaceSelector.new(player.board).fire!
    @messages << "The computer's shot resulted in a #{result}."
    @game.player_2_turns += 1
    @hit = 1 if result == "Hit"
  end

  def attack
    if @game.current_turn == "player_1"
      attack_opponent(opponent)
    elsif @game.current_turn == "player_2"
      attack_opponent(player)
    end
    next_turn
  end

  def ai_battle
    attack_opponent(opponent)
    ai_attack_back
  end

  def next_turn
    if @game.current_turn == "player_1"
      @game.current_turn = "player_2"
    elsif @game.current_turn == "player_2"
      @game.current_turn = "player_1"
    end
  end

  def player
    Player.new(@game.player_1_board)
  end

  def opponent
    Player.new(@game.player_2_board)
  end

  def set_winner
    @game.game_over = true
    user = User.find_by_api_key(key)
    if user != nil
      winner = user.email
    else
      winner = "Computer Wins"
    end
    @game.update_attribute(:winner, winner)
    @game.save!
  end
end
