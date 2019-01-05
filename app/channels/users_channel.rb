class UsersChannel < ApplicationCable::Channel
  def subscribed
    stream_from("SUBSCRIBLER::#{current_user.id}")
    Connection::SubscriberService.new(current_user).perform
  end

  def receive(data)
    Connection::PublisherService.new(data).perform
  end
end
