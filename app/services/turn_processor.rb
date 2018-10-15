class TurnProcessor
  def initialize(game, target)
    @game   = game
    @target = target
    @messages = []
  end

  def run!
    begin
      attack_opponent
      # ai_attack_back
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
    if game.current_turn == 0
      attack_opponent(opponent)
    elsif game.current_turn == 1
      attack_opponent(player)
    end
  end

  def player
    Player.new(game.player_1_board)
  end

  def opponent
    Player.new(game.player_2_board)
  end

end
