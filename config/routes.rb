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
  resources :products 
  #Llamada metodo PM
  post 'demands/calcular_demanda_promedio', to: 'demands#calcular_demanda_promedio'
  #Llamada metodo PMP
  post 'demands/calcular_demanda_promedio_ponderada', to: 'demands#calcular_demanda_promedio_ponderada'
  get "up" => "rails/health#show", as: :rails_health_check

end
