Rails.application.routes.draw do
  resources :datasets
  get 'home/index'
  get '/checkout_success', to: 'access_codes#new'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resource :user, only: :show
  root to: 'datasets#index'
end
