class CreateGameMappings < ActiveRecord::Migration[5.1]
  def change
    create_table :game_mappings do |t|
      t.references :game_mapping_group
      t.references :challenge
      t.integer :sort

      t.timestamps
    end
  end
end
