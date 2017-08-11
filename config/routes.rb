Rails.application.routes.draw do
  root 'home#index'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  post "logout" => "sessions#destroy"
end