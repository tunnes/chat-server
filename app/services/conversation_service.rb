class ConversationService
  def initialize(user)
    @user = user
  end

  def fill_conversations
    UsersChannel.broadcast_to(@user, fill_conversations_data)
  end

  def fill_contacts
    UsersChannel.broadcast_to(@user, fill_contacts_data)
  end

  private

  def fill_conversations_data
    {
      type: 'FILL_CONVERSATIONS',
      payload: @user.conversations.as_json(include: %i[messages users])
    }
  end

  def fill_contacts_data
    {
      type: 'FILL_CONTACTS',
      payload: User.all.where.not(id: @user.id).as_json
    }
  end
end