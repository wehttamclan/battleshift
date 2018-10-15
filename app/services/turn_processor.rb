class TurnProcessor
  def initialize(game, target)
    @game   = game
    @target = target
    @messages = []
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

  private

  attr_reader :game, :target

  def attack_opponent(opposition)
    result = Shooter.fire!(board: opposition.board, target: target)
    @messages << "Your shot resulted in a #{result}."
    game.player_1_turns += 1
  end

  def ai_attack_back
    result = AiSpaceSelector.new(player.board).fire!
    @messages << "The computer's shot resulted in a #{result}."
    game.player_2_turns += 1
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

  def valid_move?
    
  end

  def player
    Player.new(game.player_1_board)
  end

  def opponent
    Player.new(game.player_2_board)
  end

end
