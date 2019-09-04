class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :pin
      t.references :language
      t.integer :mode
      t.integer :difficulty
      t.integer :status

      t.timestamps
    end
  end
end
