module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = token_decoder ? user : reject_unauthorized_connection
    end

    private

    def token_decoder
      @token_decoder ||= Authentication::TokenService.decode(request.params[:token])
    end

    def user
      User.find(token_decoder[:id])
    end

  end
end