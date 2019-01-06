require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  # TODO..
  post '/authentication', action: :index, controller: 'authentication'
  post '/authentication/validation', action: :validation, controller: 'authentication'
  post '/user', action: :create_user, controller: 'authentication'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_WEB_USER'])) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_WEB_PASSWORD']))
  end
  mount Sidekiq::Web, at: '/sidekiq'

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
