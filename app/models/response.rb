class Response < ApplicationRecord
  belongs_to :challenge_game
  belongs_to :user
end
