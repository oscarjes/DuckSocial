Rails.application.routes.draw do
  root 'home#index'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :friendships, only: [:new, :create, :destroy]

  post "logout" => "sessions#destroy"
  get "users" => "users#index"
  get "profile" => "users#edit"
  post "update" => "users#update"
  delete "unfriend" => "friendships#destroy"
end