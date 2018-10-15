require 'rails_helper'

RSpec.describe Player, type: :model do
  it 'exists' do
    board = board
    player = Player.new(board)

    expect(player).to be_a Player
  end
end
