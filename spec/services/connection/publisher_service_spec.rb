require 'rails_helper'
require "action_cable/testing/rspec"

RSpec.describe Connection::BroadcastService do
  include ActionCable::TestHelper

  let(:user) { create(:user) }
  let(:users) { [ user, create(:user) ] }
  let(:conversation) { create(:conversation, :with_messages, users: users) }
  let(:message) { create(:message, conversation: conversation) }

  let(:create_message_params) {
    {
      type: 'CREATE_MESSAGE',
      payload: { user_id: user.id, users: users.map(&:id), content: Faker::Lorem.sentence, conversation_id: conversation.id }
    }
  }

  let(:conversation_payload) { { user_id: user.id, users: users.map(&:id), content: Faker::Lorem.sentence } }

  let(:create_conversation_params) {
    { type: 'CREATE_CONVERSATION', payload: conversation_payload }
  }

  let(:create_group_params) {
    { type: 'CREATE_GROUP', payload: conversation_payload }
  }

  context "#perform" do
    it "- brodecast create message" do
      expect{
        Connection::PublisherService.new(create_message_params).perform
      }.to have_broadcasted_to("SUBSCRIBLER::#{user.id}").from_channel(UsersChannel)
    end

    it "- brodecast create conversation" do
      expect{
        Connection::PublisherService.new(create_conversation_params).perform
      }.to have_broadcasted_to("SUBSCRIBLER::#{user.id}").from_channel(UsersChannel)
    end

    it "- brodecast create group" do
      expect{
        Connection::PublisherService.new(create_group_params).perform
      }.to have_broadcasted_to("SUBSCRIBLER::#{user.id}").from_channel(UsersChannel)
    end
  end

end