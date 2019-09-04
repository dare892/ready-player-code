class CreateChallengeGames < ActiveRecord::Migration[5.1]
  def change
    create_table :challenge_games do |t|
      t.references :game
      t.references :challenge

      t.timestamps
    end
  end
end
