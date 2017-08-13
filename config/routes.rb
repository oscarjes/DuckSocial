Rails.application.routes.draw do
  root 'home#index'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :friendships, only: [:new, :create, :destroy]
  resources :messages
  resources :wall_posts

  post "logout" => "sessions#destroy"
  get "users" => "users#index"
  get "settings" => "users#edit"
  post "update" => "users#update"
  delete "unfriend" => "friendships#destroy"
  get 'inbox' => 'messages#inbox'
  get 'messages/new'
  get 'sent' => 'messages#sent'
  get 'friends/new' => "users#find"
  get 'profile' => 'users#show'
end