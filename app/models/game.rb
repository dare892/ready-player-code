class Game < ApplicationRecord
  belongs_to :room, optional: true
  has_many :challenge_games
  has_many :challenges, through: :challenge_games
  has_many :users, through: :room
  has_many :game_results

  enum status: ['playing','finished']

  QUOTES = [
    "Any fool can write code that a computer can understand. Good programmers write code that humans can understand. <br> ― Martin Fowler",
    "That's the thing about people who think they hate computers. What they really hate is lousy programmers. <br> ― Larry Niven",
    "Code is like humor. When you have to explain it, it’s bad. <br> – Cory House",
    "First, solve the problem. Then, write the code. <br> – John Johnson"
  ]

  def setup(s)
    # difficulty = self.room.difficulty
    difficulty = 'beginner'
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

  def win(current_user)
    current_user.earn_points('game')
    current_user.increment!(:win)
    current_user.game_results.find_or_create_by(game: self, result: 'win')
    self.users.where.not(id: current_user.id).each do |other_user|
      other_user.increment!(:loss)
      other_user.game_results.find_or_create_by(game: self, result: 'loss')
    end
  end

  def winners
    User.where(id: self.game_results.where(result: 'win').pluck(:user_id))
  end

  def losers
    User.where(id: self.game_results.where(result: 'loss').pluck(:user_id))
  end
end
