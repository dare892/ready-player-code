class Challenge < ApplicationRecord
  belongs_to :language
  
  enum difficulty: ['beginner', 'easy', 'medium', 'hard', 'master']
end
