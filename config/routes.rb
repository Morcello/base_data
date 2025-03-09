Rails.application.routes.draw do
  root to: 'access_registries#index'

  get "register_of_owners/form"
  get "register_of_owners/import"
  post "register_of_owners/import"

  devise_for :users
  resources :register_of_owners
  resources :access_registries
  resources :service_cancellations
  resources :register_of_documents

  resources :register_of_owners do
    member do
      post 'upload_scan', to: 'register_of_owners#upload_scan'
    end
  end
end
