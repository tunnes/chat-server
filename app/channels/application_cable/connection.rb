module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = token ? user : reject_unauthorized_connection
    end

    private

    def token
      @token ||= Authentication::TokenService.decode(request.params[:token])
    end

    def user
      User.find(token[:id])
    end
  end
end
