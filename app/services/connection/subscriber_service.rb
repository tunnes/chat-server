class Connection::SubscriberService
  def initialize(user)
    @user = user
  end

  def perform
    Connection::BroadcastService.perform(fill_contacts_data, @user.id)
    Connection::BroadcastService.perform(fill_conversations_data, @user.id)
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