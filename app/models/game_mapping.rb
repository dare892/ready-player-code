class GameMapping < ApplicationRecord
  belongs_to :game_mapping_group
  belongs_to :challenge
end
