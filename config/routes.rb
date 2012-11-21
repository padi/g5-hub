G5Hub::Application.routes.draw do
  resources :clients
  resources :features
  resources :locations, except: [:index]
  root to: "clients#index"
end
