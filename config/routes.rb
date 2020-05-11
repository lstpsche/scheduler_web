# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

  # Will leave it here for a while to not crash all server-side routes
  # TODO: fix all routes to using api/v1
  devise_for :users, only: %i[sessions registrations],
    controllers: {
      registrations: 'api/v1/devise_custom/registrations',
      sessions: 'api/v1/devise_custom/sessions'
    },
    path: '',
    path_names: { sign_in: 'sign_in', sign_out: 'sign_out' },
    defaults: { format: :json }

  namespace :api do
    namespace :v1 do
      devise_for :users, only: %i[sessions registrations],
        controllers: {
          registrations: 'api/v1/devise_custom/registrations',
          sessions: 'api/v1/devise_custom/sessions'
        },
        path: '',
        path_names: { sign_in: 'sign_in', sign_out: 'sign_out' },
        defaults: { format: :json }

      resources :schedules, except: :edit do
        resources :events, only: %i[create update destroy]
      end

      post 'bot_login', to: 'bot_login#login'

      scope :admin do
        resources :users, module: :admin, only: :index
      end

      get '/auth/signed_in', to: 'auth#signed_in'

      post '/users/show/:id', to: 'users#show_attributes'
      get '/users/show_current', to: 'users#show_current'
    end
  end

  # should be always the LAST
  get '/*path' => 'home#index'
end
