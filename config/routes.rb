Rails.application.routes.draw do
  # resources :meals
  get '/meals', to: 'meals#index', as: 'meals'
  post '/meals', to: 'meals#create', as: 'new_meal'
  patch '/meals/:id', to: 'meals#update', as: 'meal'
  delete '/meals/:id', to: 'meals#destroy'
  
  resources :recipe_ingredients
  
  # resources :recipes, only: [:index]
  get '/recipes/limit=:limit/offset=:offset', to: 'recipes#index', as: 'recipes'
  get '/recipes/:id', to: 'recipes#show', as: 'recipe'
  get '/recipes/:id/ingredients', to:'recipes#ingredients'

  delete '/recipes/:id', to: 'recipes#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
