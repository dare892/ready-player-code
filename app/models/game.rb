class Game < ApplicationRecord
  belongs_to :room, optional: true
  has_many :challenge_games
  has_many :challenges, through: :challenge_games
  
  enum status: ['playing','finished']
  
  def setup
    # difficulty = self.room.difficulty
    difficulty = 'easy'
    gmg = GameMappingGroup.where(difficulty: difficulty).shuffle.first
    gmg.game_mappings.order(:sort).each_with_index do |game_mapping, index|
      self.challenge_games.create(
        challenge: game_mapping.challenge, 
        sort: index
      )
    end
  end
  
  def completed_all_challenges(current_user)
    (self.challenge_games.pluck(:id).uniq.sort - current_user.responses.where(challenge_game_id: self.challenge_games.pluck(:id)).pluck(:challenge_game_id).uniq.sort).blank?
  end
end
