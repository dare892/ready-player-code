class Challenge < ApplicationRecord
  belongs_to :language
  has_many :challenge_answers
  
  enum difficulty: ['beginner', 'easy', 'medium', 'hard', 'master']
end
