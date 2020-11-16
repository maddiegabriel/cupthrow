class AddThrowColsToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :throw_desc, :string
  end
end
