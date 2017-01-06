Rails.application.routes.draw do

  root 'landing#index'
  resources :items, only: [:index, :show]
  resources :carts, only: [:create, :show, :destroy]
  get '/login', to: "sessions#new"
  get '*category' => 'categories#index'
end
