Rails.application.routes.draw do
  resources :meals
  resources :recipe_ingredients
  # resources :recipes, only: [:index]
  get '/recipes/limit=:limit/offset=:offset', to: 'recipes#index', as: 'recipes'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
