Rails.application.routes.draw do
  root to: 'access_registrys#index'

  devise_for :users

end
