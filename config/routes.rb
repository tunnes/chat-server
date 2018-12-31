require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  # TODO..
  post '/authentication', action: :index, controller: 'authentication'
  post '/authentication/validation', action: :validation, controller: 'authentication'
  post '/user', action: :create_user, controller: 'authentication'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'

  get 'job/submit/:who/:message', to: 'job#submit'
end
