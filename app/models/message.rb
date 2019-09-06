class Message < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :room, optional: true
  
  after_create do
    if self.room
      self.room.emit({'data_type':'chat', 'message':self})
    elsif self.user
      self.user.emit({'data_type':'chat', 'message':self})
    end
  end
end
