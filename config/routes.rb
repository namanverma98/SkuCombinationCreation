Rails.application.routes.draw do
  root to: 'visitors#index'
  # User Resources
  devise_for :users
  resources :users

  # SKU Resources
  resources :stock_keeping_units
  post '/import', to: 'stock_keeping_units#import'


end
