Rails.application.routes.draw do
  root to: 'access_registries#index'

  devise_for :users
  resources :register_of_owners
  resources :access_registries
  resources :service_cancellations
end
