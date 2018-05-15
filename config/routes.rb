Rails.application.routes.draw do
  root "static_pages#home"
  get "/signup", to: "users#new"
  post "/signup",  to: "users#create"
  resources :users
  resources :account_activations, only: [:edit]
  resources :categories
  resources :products
end
