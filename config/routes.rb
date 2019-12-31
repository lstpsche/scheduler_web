# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users, only: %i[sessions registrations], controllers: { registrations: 'devise_custom/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :schedules, except: %i[edit] do
    resources :events, only: %i[create destroy]
  end

  post 'bot_login', action: :login, controller: 'bot_login'

  scope :admin do
    resources :users, module: :admin, only: %i[index]
  end
end
