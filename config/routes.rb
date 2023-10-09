Rails.application.routes.draw do
  devise_for :users

  resources :foods, only: [:index, :new, :create]

  root 'foods#index'
end
