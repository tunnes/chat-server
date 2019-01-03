require 'rails_helper'

RSpec.describe Connection::Data::ConversationData do
  let(:user) { create(:user) }
  let(:users) { create_list(:user, 2) }

  subject {
    data = {
      type: 'CREATE_CONVERSATION',
      payload: { user_id: user.id, users: users.map(&:id), content: Faker::Lorem.sentence }
    }

    Connection::Data::ConversationData.new(data)
   }

  it "#create_conversation" do
    data = subject.create_conversation.deep_symbolize_keys
    expect(data[:payload][:access_type]).to eq(Conversation.statuses[:private_conversation])
  end

  it '#create_group' do
    data = subject.create_group.deep_symbolize_keys
    expect(data[:payload][:access_type]).to eq(Conversation.statuses[:group_conversation])
  end

  it '#conversation_data' do
    expect(subject.create_conversation[:type]).to eq('ADD_CONVERSATION')
  end

  it '#save_conversation' do
    expect{ subject.create_conversation }.to change{ Conversation.count }.by(1)
  end
end