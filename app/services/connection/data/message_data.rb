class Connection::Data::MessageData
  def initialize(data)
    @data = data[:payload]
  end

  def create_message
    MessageWorker.perform_async(message_params)
    message_data
  end

  private

  def message_params
    {
      created_at: DateTime.now,
      user_id: @data[:user_id],
      content: @data[:content],
      conversation_id: @data[:conversation_id],
    }
  end

  def message_data
    { type: 'ADD_MESSAGE', payload: message_params }
  end

end