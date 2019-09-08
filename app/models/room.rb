class Room < ApplicationRecord
  belongs_to :language
  has_many :messages, dependent: :destroy
  has_many :room_users, dependent: :destroy
  has_many :users, through: :room_users
  has_many :games

  enum mode: ['free_for_all']
  enum status: ['pending','playing']
  enum difficulty: ['beginner', 'easy', 'medium', 'hard', 'master']

  validates_presence_of :language_id, :name

  before_create do
    self.mode = 'free_for_all'
    self.difficulty = 'beginner'
  end

  def host
    room_users.order(:created_at).first.user
  end

  def emit(data)
    case data[:data_type]
    when 'user'
      case data[:message]
      when 'player_joined'
        ActionCable.server.broadcast "room_#{self.id}_channel",
          data_type: data[:data_type],
          message: data[:message],
          session_hash: data[:session_hash]
      when 'player_left'
        ActionCable.server.broadcast "room_#{self.id}_channel",
          data_type: data[:data_type],
          message: data[:message],
          session_hash: data[:session_hash],
          player_name: data[:player_name]
      end
    when 'chat'
      message = data[:message]
      room = message.room
      user = message.user
      if user
        display_name = "#{user.name} : "
      else
        display_name = ""
      end
      ActionCable.server.broadcast "room_#{self.id}_channel",
        data_type: 'chat',
        sender_name: display_name,
        chat_body: message.body
    when 'game_status'
      ActionCable.server.broadcast "room_#{self.id}_channel",
        data_type: 'game_status',
        message: data[:message],
        game_id: data[:game_id]
    when 'in_game'
      case data[:message]
      when 'completed_challenge'
        ActionCable.server.broadcast "room_#{self.id}_channel",
          data_type: data[:data_type],
          message: data[:message],
          session_hash: data[:session_hash]
      when 'completed_game'
        ActionCable.server.broadcast "room_#{self.id}_channel",
          data_type: data[:data_type],
          message: data[:message],
          session_hash: data[:session_hash],
          player_name: data[:player_name]
      end
    else
      puts "Not sure how to handle."
    end
  end
end
