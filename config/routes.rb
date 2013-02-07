G5Hub::Application.routes.draw do
  resources :clients
  resources :locations, only: [ :index, :show ]
  root to: "clients#index"
end
