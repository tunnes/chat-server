require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe Connection::Data::MessageData do
  let(:user) { create(:user) }
  let(:users) { [ user, create(:user) ] }
  let(:conversation) { create(:conversation, :with_messages, users: users) }
  let(:message) { create(:message, conversation: conversation) }

  subject {
    data = {
      type: 'CREATE_MESSAGE',
      payload: { user_id: user.id, users: users.map(&:id), content: Faker::Lorem.sentence, conversation_id: conversation.id }
    }

    Connection::Data::MessageData.new(data)
  }

  context "#create_message" do
    it "- create a job" do
      expect{ subject.create_message }.to change(MessageWorker.jobs, :size).by(1)
    end

    it "- create a message in database" do
      message_params = build(:message, conversation: conversation).attributes
      expect{ MessageWorker.new.perform(message_params) }.to change{ Message.count }.by(1)
    end
  end

  it '#message_data' do
    expect(subject.create_message[:type]).to eq('ADD_MESSAGE')
  end
end