require 'rails_helper'

RSpec.describe UsersChannel, type: :channel do
  include ActionCable::TestHelper

  let(:current_user) { create :user }
  let(:action_cable) { ActionCable.server }
  let(:users) { [ current_user, create(:user) ] }
  let(:conversation) { create(:conversation, :with_messages, users: users) }
  let(:message) { create(:message, conversation: conversation) }

  let(:create_message_params) do
    {
      type: 'CREATE_MESSAGE',
      payload: {
        user_id: current_user.id,
        users: users.map(&:id),
        content: Faker::Lorem.sentence,
        conversation_id: conversation.id
      }
    }
  end

  it '#subscribed' do
    stub_connection(current_user: current_user)
    subscribe
    assert subscription.confirmed?
  end

  it '#receive' do
    stub_connection(current_user: current_user)
    subscribe
    expect{ perform(:receive, create_message_params) }.to have_broadcasted_to("SUBSCRIBLER::#{current_user.id}")
  end
end