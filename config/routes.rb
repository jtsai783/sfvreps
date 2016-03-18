Rails.application.routes.draw do
  
  root 'index#index'
  resources :players do
  	resources :comments
  end
  
end
