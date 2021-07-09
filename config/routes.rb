require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks" 
  }
  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new', as: :new_user_session
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  get '/destroy', to: "users#destroy"

  root to: "pages#index"
end
