FactoryBot.define do
  factory :game do
    player_1_board { Board.new(4) }
    player_2_board { Board.new(4) }
    winner nil
  end
end
