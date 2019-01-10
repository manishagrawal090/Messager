Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index]
  resources :personal_messages, only: [:new, :create]
  resources :conversations, only: [:index, :show]

  root 'conversations#index'

  resources :chat_rooms, only: [:new, :create, :show, :index,:destroy]

  mount ActionCable.server => '/cable'
end
