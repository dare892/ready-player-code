class GameMappingGroup < ApplicationRecord
  belongs_to :language
  has_many :game_mappings
  
  enum difficulty: ['beginner', 'easy', 'medium', 'hard', 'master']
end
