class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  has_many :room_users, dependent: :destroy
  has_many :responses, dependent: :destroy
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
end
