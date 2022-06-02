Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/create'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root to: 'charts#index'
  resources :charts

  resources :items, only: [:show, :new, :create]
  resources :viewpoints, only: [:show, :new, :create]
  resources :evaluations, only: [:show, :new, :create]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create]
 
end
