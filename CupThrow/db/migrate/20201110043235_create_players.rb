class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :username
      t.string :email
      t.string :password
      t.integer :points
      t.integer :gems

      t.timestamps
    end
  end
end
