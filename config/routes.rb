G5Hub::Application.routes.draw do
  resources :clients
  resources :locations
  root to: "clients#index"
end
