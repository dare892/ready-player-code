class CreateChallengeAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :challenge_answers do |t|
      t.references :challenge
      t.text :input
      t.text :output
      t.boolean :is_test, default: false

      t.timestamps
    end
  end
end
