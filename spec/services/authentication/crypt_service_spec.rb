require 'rails_helper'

RSpec.describe Authentication::CryptService do
  let(:user) { create :user }
  let(:cryto) { Authentication::CryptService.encode(user.password) }
  let(:decryto) { Authentication::CryptService.decode(cryto, user.password) }

  it '#encode' do
    expect(cryto).to be_kind_of(String)
  end

  it '#decode' do
    expect(decryto).to be_truthy
  end
end