class AddGoalScoreToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :goal_score, :integer
  end
end
