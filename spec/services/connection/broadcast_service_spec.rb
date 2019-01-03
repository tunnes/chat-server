require 'rails_helper'
require 'sidekiq/testing'
require "action_cable/testing/rspec"

RSpec.describe Connection::BroadcastService do
  include ActionCable::TestHelper

  let(:user) { create(:user) }

  it "#perform" do
    assert_broadcasts("SUBSCRIBLER::#{user.id}", 1) {
      Connection::BroadcastService.perform({}, user.id)
    }
  end

end