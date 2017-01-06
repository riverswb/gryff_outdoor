Rails.application.routes.draw do

  resources :items, only: [:index, :show]
  resources :carts, only: [:create, :show, :destroy]
  get '*category' => 'categories#index'
  get '/' => 'landing#index'
  patch '/carts/:id' => 'carts#update'

end
