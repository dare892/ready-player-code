class CreateRoomUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :room_users do |t|
      t.references :user
      t.references :room
      t.integer :role

      t.timestamps
    end
  end
end
