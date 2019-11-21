# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { passwords: 'devise_custom/passwords', sessions: 'devise_custom/sessions',
                                    registrations: 'devise_custom/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :schedules do
    resources :events
  end

  post 'bot_login', action: :login, controller: 'bot_login'

  scope :admin do
    resources :users, module: :admin, only: %i[index]
  end
end
