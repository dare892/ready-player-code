class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.references :room
      t.string :name

      t.timestamps
    end
  end
end
