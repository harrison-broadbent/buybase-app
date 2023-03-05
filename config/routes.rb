Rails.application.routes.draw do
  resources :datasets
  get 'home/index'
  get '/checkout_success', to: 'data_codes#new'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: :show
  root to: 'home#index'
end
