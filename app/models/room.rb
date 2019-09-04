class Room < ApplicationRecord
  belongs_to :language
  has_many :messages, dependent: :destroy
  has_many :room_users, dependent: :destroy
  
  enum mode: ['free_for_all']
  enum status: ['pending','playing']
  enum difficulty: ['beginner', 'easy', 'medium', 'hard', 'master']
  
  def host
    room_users.order(created_at: :desc).first.user
  end
  
  def emit(data)
    case data[:data_type]
    when 'chat'
      message = data[:message]
      room = message.room
      user = message.user
      ActionCable.server.broadcast "room_#{room.id}_channel", 
        data_type: 'chat',
        sender_name: user.name,
        chat_body: message.body
    else
      puts "Not sure how to handle."
    end
  end
end
