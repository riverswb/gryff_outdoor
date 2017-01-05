Rails.application.routes.draw do
  resources :items, only: [:index]

  get '/' => 'landing#index'
end
