Rails.application.routes.draw do
  get 'sessions/new'
  resources :tasks
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  root to: 'tasks#index'
end
