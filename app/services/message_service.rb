class MessageService
  def initialize(user)
    @user = user
  end

  def perform(data)
    case data['type']
      when 'CREATE_MESSAGE'
        if data['payload']['conversation_id'].present?
          create_message(data)
        else
          create_conversation(data)
        end
      when 'CREATE_GROUP'
        create_group(data)
      else
        UsersChannel.broadcast_to(@user, 'tipo não identificado..')
    end
  end

  private

  def create_conversation(data)
    conversation = Conversation.create(access_type: 0)
    conversation.users << @user
    conversation.users << User.find(data['payload']['receiver_id'])
    message = Message.create(
      user_id: data['payload']['user_id'],
      content: data['payload']['content'],
      conversation_id: conversation.id,
    )

    UsersChannel.broadcast_to(@user,{
      type: 'CREATE_CONVERSATION',
      payload: conversation.as_json(include: %i[messages users])
    })

    UsersChannel.broadcast_to(User.find(data['payload']['receiver_id']),{
      type: 'CREATE_CONVERSATION',
      payload: conversation.as_json(include: %i[messages users])
    })
  end

  def create_group(data)
    conversation = Conversation.create(access_type: 1)
    conversation.users << @user
    conversation.users << User.where(id: data['payload']['users'])

    conversation.users.map { |user|
      opts = { type: 'CREATE_CONVERSATION', payload: conversation.as_json(include: %i[messages users])}
      UsersChannel.broadcast_to(user, opts)
    }
  end

  def create_message(data)
    message = Message.create(
      user_id: data['payload']['user_id'],
      content: data['payload']['content'],
      conversation_id: data['payload']['conversation_id'],
    )
    UsersChannel.broadcast_to(@user, {type: 'ADD_MESSAGE', payload: message })
    UsersChannel.broadcast_to(User.find(data['payload']['receiver_id']), {type: 'ADD_MESSAGE', payload: message })
  end
end