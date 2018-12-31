class Connection::PublisherService
  def initialize(data)
    @data = data.deep_symbolize_keys
  end

  def perform
    case @data[:type]
      when 'CREATE_MESSAGE'
        broadcast Connection::Data::MessageData.new(@data).create_message
      when 'CREATE_CONVERSATION'
        broadcast Connection::Data::ConversationData.new(@data).create_conversation
      when 'CREATE_GROUP'
        broadcast Connection::Data::ConversationData.new(@data).create_group
    end
  end

  private

  def broadcast(payload)
    Connection::BroadcastService.perform(payload, @data[:payload][:users])
  end
end