Rails.application.routes.draw do
  resources :items, only: [:index]

  get '*category' => 'categories#index'
end
