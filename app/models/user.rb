class User < ApplicationRecord
  ############################################################################################
  ## PeterGate Roles                                                                        ##
  ## The :user role is added by default and shouldn't be included in this list.             ##
  ## The :root_admin can access any page regardless of access settings. Use with caution!   ##
  ## The multiple option can be set to true if you need users to have multiple roles.       ##
  petergate(roles: [:admin, :editor], multiple: false)                                      ##
  ############################################################################################


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :room_users, dependent: :destroy
  has_many :responses, dependent: :destroy
  has_many :game_results
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  before_create do
    self.session_hash = generate_hash
  end

  def generate_hash(hash = Digest::SHA1.hexdigest([Time.now, rand].join)[0..10])
    if User.find_by(session_hash: hash)
      return self.generate_hash
    else
      return hash
    end
  end


  ########## cable
  def emit(data)
    case data[:data_type]
    when 'user'
      #
    when 'chat'
      message = data[:message]
      user = message.user
      ActionCable.server.broadcast "main_channel",
        data_type: 'chat',
        sender_name: user.try(:name),
        chat_body: message.body
    end
  end


  ########## points
  def earn_points(reward)
    case reward
    when 'challenge'
      pts = 10
    when 'game'
      pts = 100
    end
    self.points = self.points.to_i + pts
    self.save(validate: false)
  end
end
