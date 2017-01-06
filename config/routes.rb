Rails.application.routes.draw do

  root 'landing#index'
  resources :items, only: [:index, :show]
  resources :carts, only: [:create, :show, :destroy]
  resources :users, only: [:new, :create]
  get '/dashboard', to: "users#show"
  get '/login', to: "sessions#new"
  get '/logout', to: "sessions#destroy"
  get '*category' => 'categories#index'
  get '/' => 'landing#index'
  patch '/carts/:id' => 'carts#update'
end
