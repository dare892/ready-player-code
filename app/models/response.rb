class Response < ApplicationRecord
  belongs_to :challenge_game
  belongs_to :user
  
  def room
    self.challenge_game.game.room
  end
end
