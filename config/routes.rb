Rails.application.routes.draw do

  root 'landing#index'
  delete '/carts', to: "carts#destroy", as: "carts"
  get '/cart', to: "carts#show", as: "cart"
  patch '/cart' => 'carts#update'
  resources :items, only: [:index, :show]
  resources :carts, only: [:create]
  resources :users, only: [:new, :create]
  get '/dashboard', to: "users#show"
  get '/login', to: "sessions#new"
  get '/logout', to: "sessions#destroy"
  get '/:category' => 'categories#index'
  patch '/carts/:id' => 'carts#update'
end
