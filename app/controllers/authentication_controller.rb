class AuthenticationController < ApplicationController
  def index
    render valid_access? ? { json: success_response(user), status: 200 } : { json: nil, status: 401 }
  end

  def validation
    render valid_token? ? { json: true, status: 200 } : { json: false, status: 401 }
  end

  def create_user
    user = User.new(user_params)

    if user.valid?
      user.save!
      render({ json: success_response(user), status: 200 })
    else
      render({ json: user.errors, status: 401 })
    end
  end

  private

  def user_params
    params.permit(:full_name, :user_name, :password)
  end

  def valid_token?
    Authentication::TokenService.decode(params[:token])
  end

  def valid_access?
    Authentication::CryptService.decode(user.try(:password), params[:password])
  end

  def success_response(u)
    {
      data: u.as_json(except: :password),
      token: Authentication::TokenService.encode(user.as_json)
    }
  end

  def user
    @user ||= User.find_by(user_name: params[:user_name])
  end
end
