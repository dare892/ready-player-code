class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_#{params['room_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def emit(data)
    case data['data_type']
    when 'test'
      ActionCable.server.broadcast "room_#{data['room_id']}_channel", 
        data_type: data['data_type']
    else
      ActionCable.server.broadcast "room_#{data['room_id']}_channel"
    end
  end
end
