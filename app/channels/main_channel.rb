class MainChannel < ApplicationCable::Channel
  def subscribed
    stream_from "main_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
