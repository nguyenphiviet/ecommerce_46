Rails.application.routes.draw do
  root "static_pages#home"
  get "/signup", to: "users#new"
  post "/signup",  to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :account_activations, only: %i(edit)
  resources :carts, only: %(index)
  resources :categories
  resources :items
  resources :order_details
  resources :orders
  resources :products
  resources :users, except: %i(index)
  resources :products, only: %i(index show) do
    resources :comments
    resources :ratings
  end
  namespace :admin do
    root "static_pages#home"
    resources :users, only: %i(index edit update destroy)
    resources :products
  end
end
