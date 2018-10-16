class TurnProcessor
  def initialize(game, target, shooting_player)
    @game   = game
    @target = target
    @messages = []
    @shooting_player = shooting_player
  end

  def run!
    begin
      # correct_player?
      attack if correct_player?
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

  def correct_player?
    @messages << "Invalid move. It's your opponent's turn"
  end

  def attack
    if game.current_turn == 'player_1'
      result = Shooter.fire!(board: game.player_2_board, target: target)
      @messages << "Your shot resulted in a #{result}."
      game.player_1_turns += 1
      game.update(current_turn: 1)
    elsif game.current_turn == 'player_2'
      result = Shooter.fire!(board: game.player_1_board, target: target)
      @messages << "Your shot resulted in a #{result}."
      game.player_2_turns += 1
      game.update(current_turn: 0)
    end
  end

  # def player
  #   Player.new(game.player_1_board)
  # end
  #
  # def opponent
  #   Player.new(game.player_2_board)
  # end

end
