class AddPlayersToGames < ActiveRecord::Migration[5.1]
  def change
    add_reference :games, :player_1, foreign_key: { to_table: :users }
    add_reference :games, :player_2, foreign_key: { to_table: :users }
  end
end
