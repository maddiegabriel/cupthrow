class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :goal_description
      t.string :server_throw
      t.integer :player_id
      t.integer :player_score
      t.integer :server_score

      t.timestamps
    end
  end
end
