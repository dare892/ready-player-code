class CreateChallenges < ActiveRecord::Migration[5.1]
  def change
    create_table :challenges do |t|
      t.string :title
      t.text :description
      t.integer :difficulty
      t.integer :input_type
      t.boolean :published, default: false
      t.timestamps
    end
  end
end
