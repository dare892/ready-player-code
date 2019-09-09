class GameResult < ApplicationRecord
  belongs_to :game
  belongs_to :user
  
  enum result: ['win','loss']
end
