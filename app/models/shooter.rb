class Shooter
  attr_reader :target, :board
  def initialize(board:, target:)
    @board     = board
    @target    = target
    @message   = ""
  end

  def fire!
    space.attack!
  end

  def space
    @space ||= board.locate_space(target)
  end
end
