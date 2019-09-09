class CreateGameResults < ActiveRecord::Migration[5.1]
  def change
    create_table :game_results do |t|
      t.references :game
      t.references :user
      t.integer :result
      t.timestamps
    end
  end
end
