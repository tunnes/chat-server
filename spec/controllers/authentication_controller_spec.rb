require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  let(:user_pass) { Faker::Internet.password }
  let(:user) { create(:user, password: user_pass) }
  let(:user_token) { Authentication::TokenService.encode(user.as_json) }

  context "#index" do
    it "- 200" do
      post :index, params: { password: user_pass, user_name: user.user_name }
      expect(response).to have_http_status(200)
    end

    it "- 401" do
      post :index, params: { password: Faker::Internet.password, user_name: Faker::Internet.username }
      expect(response).to have_http_status(401)
    end
  end

  context "#validation" do
    it "- 200" do
      post :validation, params: { token: user_token }
      expect(response).to have_http_status(200)
    end

    it "- 401" do
      post :validation, params: { token: nil }
      expect(response).to have_http_status(401)
    end
  end

  context "#create_user" do
    it "- 200" do
      post :create_user, params: attributes_for(:user)
      expect(response).to have_http_status(200)
    end

    it "- 422" do
      post :create_user, params: { foo: 'bar' }
      expect(response).to have_http_status(422)
    end
  end

end