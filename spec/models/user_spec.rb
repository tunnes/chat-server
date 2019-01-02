require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }

  it '#create' do
    expect(user.password).to eq(user.password)
  end
end