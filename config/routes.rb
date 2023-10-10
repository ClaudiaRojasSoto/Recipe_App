Rails.application.routes.draw do
  devise_for :users

  resources :foods, only: [:index, :new, :create, :destroy]

  root 'foods#index'

  resources :recipes, only: [:index, :show, :new, :create] do
    collection do
      get 'public_recipes'
    end
  end
end
