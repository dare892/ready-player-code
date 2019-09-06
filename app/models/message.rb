class Message < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :room
  
  after_create do
    self.room.emit({'data_type':'chat', 'message':self})
  end
end
