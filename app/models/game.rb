class Game < ApplicationRecord
  belongs_to :room
  enum status: ['playing','finished']
end
