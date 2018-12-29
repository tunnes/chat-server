Rails.application.routes.draw do
  # TODO..
  post '/authentication', action: :index, controller: 'authentication'
  post '/authentication/validation', action: :validation, controller: 'authentication'
  post '/user', action: :create_user, controller: 'authentication'
end
