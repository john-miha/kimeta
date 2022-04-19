Rails.application.routes.draw do
  root to: 'charts#index'
  resources :charts

  resources :items, only: [:show, :new, :create]
  resources :viewpoints, only: [:show, :new, :create]
  resources :evaluations, only: [:show, :new, :create]
 
end
