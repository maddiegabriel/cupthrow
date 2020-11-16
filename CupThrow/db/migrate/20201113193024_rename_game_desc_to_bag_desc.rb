class RenameGameDescToBagDesc < ActiveRecord::Migration[6.0]
  def change
    rename_column :players, :game_desc, :bag_desc
  end
end
