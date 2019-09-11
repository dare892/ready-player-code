class CreateResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :responses do |t|
      t.references :challenge_game
      t.references :user
      t.references :challenge
      t.text :body

      t.timestamps
    end
  end
end
