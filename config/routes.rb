G5Hub::Application.routes.draw do
  resources :customers
  resources :features
  resources :locations, except: [:index]
  root to: "customers#index"
end
