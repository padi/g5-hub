G5Hub::Application.routes.draw do
  resources :clients
  resources :locations, except: [:index]
  root to: "clients#index"
end
