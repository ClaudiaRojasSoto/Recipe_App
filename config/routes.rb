Rails.application.routes.draw do
  devise_for :users

  get 'users', to: 'users#index', as: 'users_index'

  resources :foods, only: %i[index new create destroy]

  root 'foods#index'

  get 'recipes/shopping_list', to: 'recipes#shopping_list', as: 'shopping_list'

  resources :recipes, only: %i[index show new create destroy] do
    collection do
      get 'public_recipes'
    end
    member do
      get 'update_public'
    end
  end

  resources :recipe_foods, only: %i[new create edit destroy]
end
