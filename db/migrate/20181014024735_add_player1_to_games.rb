class AddPlayer1ToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :player_1, :string
  end
end
