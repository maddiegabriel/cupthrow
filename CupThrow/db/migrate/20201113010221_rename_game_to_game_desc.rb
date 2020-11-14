class RenameGameToGameDesc < ActiveRecord::Migration[6.0]
  def change
    rename_column :players, :game, :game_desc
  end
end
