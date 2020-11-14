class AddGameToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :game, :string
  end
end
