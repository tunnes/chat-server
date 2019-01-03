require 'rails_helper'

RSpec.describe ApplicationCable::Connection, type: :channel  do
  include ActionCable::TestHelper

  let(:current_user) { create :user }

  it "#connect" do
    connect "/cable?token=#{Authentication::TokenService.encode(current_user.as_json)}"
    assert_equal current_user.user_name, connection.current_user.user_name
  end
end