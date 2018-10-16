class TurnProcessor
  def initialize(game, target, shooting_player)
    @game   = game
    @target = target
    @messages = []
    @shooting_player = shooting_player
  end

  def run!
    begin
      attack
      game.save!
    rescue InvalidAttack => e
      @messages << e.message
    end
  end

  def message
    @messages.join(" ")
  end

  def correct_player?
    if (game.current_turn == 'player_1') && (shooting_player == game.player_2)
      @messages << "Invalid move. It's your opponent's turn"
      return false
    elsif (game.current_turn == 'player_2') && (shooting_player == game.player_1)
      @messages << "Invalid move. It's your opponent's turn"
      return false
    else
      return true
    end
  end

  def target_exists?
    @game.player_1_board.board.any? do |row|
      row.any? do |coord|
        coord.keys.include?(@target)
      end
    end
  end

  def valid_spot?
    if target_exists?
      return true
    else
      @messages << "Invalid coordinates"
      return false
    end
  end

  private

  attr_reader :game, :target, :shooting_player

  def attack
    if game.current_turn == 'player_1'
      player_1_shot
      game.player_1_turns += 1
      game.update(current_turn: 1)
    elsif game.current_turn == 'player_2'
      player_2_shot
      game.player_2_turns += 1
      game.update(current_turn: 0)
    end
  end

  def player_1_shot
    shooter = Shooter.new(board: game.player_2_board, target: target)
    result = shooter.fire!
    @messages << "Your shot resulted in a #{result}."
    if result == 'Hit'
      @messages << "Battleship sunk." if shooter.space.contents.is_sunk?
    end
  end

  def player_2_shot
    shooter = Shooter.new(board: game.player_1_board, target: target)
    result = shooter.fire!
    @messages << "Your shot resulted in a #{result}."
    if result == 'Hit'
      @messages << "Battleship sunk." if shooter.space.contents.is_sunk?
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
