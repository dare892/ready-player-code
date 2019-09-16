class GameMappingGroup < ApplicationRecord
  has_many :game_mappings
  
  enum difficulty: ['beginner', 'easy', 'medium', 'hard', 'master']
end
