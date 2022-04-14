Rails.application.routes.draw do
  root to: 'charts#index'
  resources :charts
end
