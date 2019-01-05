module Connection
  module Data
    class ConversationData
      def initialize(data)
        @data = data[:payload]
      end

      def create_conversation
        conversation = save_conversation(:private_conversation)
        initialize_conversation(conversation)
        conversation_data(conversation)
      end

      def create_group
        conversation = save_conversation(:group_conversation)
        conversation_data(conversation)
      end

      private

      def initialize_conversation(conversation)
        Message.create(
          user_id: @data[:user_id],
          content: @data[:content],
          conversation_id: conversation.id
        )
      end

      def save_conversation(type)
        conversation = Conversation.create(
          access_type: Conversation.statuses[type],
          title: @data[:title]
        )
        conversation.users << User.where(id: @data[:users])
        conversation
      end

      def conversation_data(conversation)
        {
          type: 'ADD_CONVERSATION',
          payload: conversation.as_json(include: %i[messages users])
        }
      end
    end
  end
end
