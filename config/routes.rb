Rails.application.routes.draw do

  root 'landing#index'
  delete '/carts', to: "carts#destroy", as: "carts"
  get '/cart', to: "carts#show", as: "cart"
  patch '/cart' => 'carts#update'
  resources :items, only: [:index, :show]
  resources :carts, only: [:create]
  resources :users, only: [:new, :create] do
    resources :addresses, only: [:new, :create, :edit, :destroy]
  end
  namespace :admin do
    get '/dashboard', to: "orders#dashboard"
    resources :items, only: [:index, :update]
  end
  resources :orders, only: [:index, :show, :create]
  get 'payment', to: "orders#payment"
  get '/dashboard', to: "users#show"
  post '/login', to: "sessions#create"
  get '/login', to: "sessions#new"
  get '/logout', to: "sessions#destroy"
  get '/:category' => 'categories#index'
  patch '/carts/:id' => 'carts#update'
end
