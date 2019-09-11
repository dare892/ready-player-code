class Response < ApplicationRecord
  belongs_to :challenge_game, optional: true
  belongs_to :challenge, optional: true
  belongs_to :user
  
  def room
    self.challenge_game.game.room
  end
end
