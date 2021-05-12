Rails.application.routes.draw do
  # resources :meals
  get '/meals', to: 'meals#index', as: 'meals'
  patch '/meals/:id', to: 'meals#update', as: 'meal'
  resources :recipe_ingredients
  # resources :recipes, only: [:index]
  get '/recipes/limit=:limit/offset=:offset', to: 'recipes#index', as: 'recipes'
  get '/recipes/:id', to: 'recipes#show', as: 'recipe'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
