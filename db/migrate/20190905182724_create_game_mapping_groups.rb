class CreateGameMappingGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :game_mapping_groups do |t|
      t.integer :difficulty
      t.timestamps
    end
  end
end
