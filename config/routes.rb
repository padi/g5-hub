G5Hub::Application.routes.draw do
  resources :entries, only: [ :index, :show]
  resources :tags, only: :show
  resources :clients, only: [ :index, :show ] do
    resources :locations, only: [ :index, :show ]
  end
  root to: "entries#index"
end
