module Connection
  class PublisherService
    def initialize(data)
      @data = data.deep_symbolize_keys
    end

    def perform
      Connection::BroadcastService.perform(action_type, @data[:payload][:users])
    end

    private

    def action_type
      case @data[:type]
      when 'CREATE_MESSAGE'
        Connection::Data::MessageData.new(@data).create_message
      when 'CREATE_CONVERSATION'
        Connection::Data::ConversationData.new(@data).create_conversation
      when 'CREATE_GROUP'
        Connection::Data::ConversationData.new(@data).create_group
      end
    end
  end
end
