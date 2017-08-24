Rails.application.routes.draw do
  root 'home#index'
  resources :users  do
    get :search, on: :collection, defaults: { format: 'json' }
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :friendships, only: [:new, :create, :destroy]
  resources :messages
  resources :wall_posts do
    get :paging, on: :collection
  end
  resources :comments

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
  get 'newsfeed' => 'wall_posts#index'
  post "toggle_like" => "likes#toggle"
  get 'walls/:id' => 'walls#show', as: 'wall'
  get 'search/u' => 'home#searchu'
  get 'search/p' => 'home#searchp'
end