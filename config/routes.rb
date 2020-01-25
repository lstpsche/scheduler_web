# frozen_string_literal: true

Rails.application.routes.draw do
  unauthenticated do
    root to: 'home#index'
  end

  authenticated do
    root to: 'schedules#index'
  end

  devise_for :users, only: %i[sessions registrations],
    controllers: {
      registrations: 'devise_custom/registrations',
      sessions: 'devise_custom/sessions'
    },
    path: '', path_names: { sign_in: 'sign_in', sign_out: 'sign_out' }

  resources :schedules, except: %i[edit] do
    resources :events, only: %i[create update destroy]
  end

  post 'bot_login', action: :login, controller: 'bot_login'

  scope :admin do
    resources :users, module: :admin, only: %i[index]
  end
end
