Rails.application.routes.draw do
 
  devise_for :users

  resources :users, only: [:index]
  resources :personal_messages, only: [:new, :create]
  resources :conversations, only: [:index, :show]

  # root 'conversations#index'
    root 'static#index'

  resources :chat_rooms, only: [:new, :create, :show, :index,:destroy]

  resources :friendships, only: [:create, :update, :destroy]

   
  mount ActionCable.server => '/cable'
end
