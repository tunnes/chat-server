
class UsersChannel < ApplicationCable::Channel
  def subscribed
    stream_for(current_user)
    conversation_service.fill_conversations()
    conversation_service.fill_contacts()
  end

  def receive(data)
    message_service.perform(data)
  end

  private

  def conversation_service
    @conversation_service ||= ConversationService.new(current_user)
  end

  def message_service
    # Melhorar essa classe ELA TA UM LIXO!
    @message_service ||= MessageService.new(current_user)
  end

end