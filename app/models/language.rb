class Language < ApplicationRecord
  has_many :challenges
  
  scope :published, -> { where(id: Challenge.where(published: true).pluck(:language_id)) }
end
