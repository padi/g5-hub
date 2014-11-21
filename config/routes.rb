require "resque/server"

G5Hub::Application.routes.draw do
  mount G5Authenticatable::Engine => '/g5_auth'
  mount Resque::Server, :at => "/resque"

  resources :entries, only: [:index, :show]
  resources :tags, only: :show
  resources :clients do
    resources :locations, only: [:index, :show]
    get '/location_search', to: 'clients#location_search'
  end

  resources :locations

  root to: "entries#index"
end
