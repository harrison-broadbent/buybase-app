Rails.application.routes.draw do
  resources :datasets
  resources :access_codes

  get 'analytics', to: 'analytics#index', as: "analytics"
  get '/dashboard', to: 'home#index'
  get '/checkout_success', to: 'access_codes#checkout_success'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resource :user, only: :show
  # root to: 'home#index'
  root to: 'datasets#index'
end
