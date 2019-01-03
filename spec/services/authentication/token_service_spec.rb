require 'rails_helper'

RSpec.describe Authentication::TokenService do
  let(:user) { create :user }
  let(:token) { Authentication::TokenService.encode(user.as_json) }
  let(:decoded_user) { Authentication::TokenService.decode(token) }

  it '#encode' do
    expect(token).to be_kind_of(String)
  end
  context '#decode' do
    it '- with valid token' do
      expect(decoded_user[:full_name]).to eq(user.full_name)
    end

    it '- with invalid token' do
      expect(Authentication::TokenService.decode Faker::Internet.password).to be_falsey
    end
  end
end