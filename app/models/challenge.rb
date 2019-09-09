class Challenge < ApplicationRecord
  belongs_to :language
  has_many :challenge_answers
  
  enum difficulty: ['beginner', 'easy', 'medium', 'hard', 'master']
  
  def check_answer(response)
    return 'pass'
    # docker here
  end
end
