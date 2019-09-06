class CreateGameMappingGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :game_mapping_groups do |t|
      t.integer :difficulty
      t.references :language
      t.timestamps
    end
  end
end
