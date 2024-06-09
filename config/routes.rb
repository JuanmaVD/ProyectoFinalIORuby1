Rails.application.routes.draw do
  resources :product_purchase_orders
  resources :purchase_orders
  resources :providers
  resources :product_sales
  resources :categories
  resources :demands
  resources :products
  resources :sales
  resources :clients
  
  get "up" => "rails/health#show", as: :rails_health_check

end
