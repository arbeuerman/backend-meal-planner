Rails.application.routes.draw do
  # resources :meals
  get '/meals', to: 'meals#index', as: 'meals'
  patch '/meals/:id', to: 'meals#update', as: 'meal'
  delete '/meals/:id', to: 'meals#destroy'
<<<<<<< HEAD
  
=======
>>>>>>> fc8dc0369c3640e495da43c7db84c13b8e222919
  resources :recipe_ingredients
  
  # resources :recipes, only: [:index]
  get '/recipes/limit=:limit/offset=:offset', to: 'recipes#index', as: 'recipes'
  get '/recipes/:id', to: 'recipes#show', as: 'recipe'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
