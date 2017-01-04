Rails.application.routes.draw do
  resources :items, only: [:index, :show]
  resources :carts, only: [:create, :index]
end
