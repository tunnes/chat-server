require 'rails_helper'
require 'sidekiq/testing'
require 'action_cable/testing/rspec'

RSpec.describe Connection::SubscriberService do
  include ActionCable::TestHelper

  let(:user) { create(:user) }
  let(:users) { create_list(:user, 2) }
  let(:conversation) { create(:conversation, :with_messages, users: users) }

  subject {
    Connection::SubscriberService.new(user)
  }

  it "#perform" do
    assert_broadcasts("SUBSCRIBLER::#{user.id}", 2) { subject.perform }
  end

  it "#fill_conversations_data" do
    expect(subject.send(:fill_conversations_data)[:type]).to eq('FILL_CONVERSATIONS')
  end

  it "#fill_contacts_data" do
    expect(subject.send(:fill_contacts_data)[:type]).to eq('FILL_CONTACTS')
  end
end