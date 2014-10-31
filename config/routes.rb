require "resque/server"

G5Hub::Application.routes.draw do
  mount G5Authenticatable::Engine => '/g5_auth'
  mount Resque::Server, :at => "/resque"

  resources :entries, only: [:index, :show]
  resources :tags, only: :show
  resources :clients do
    resources :locations, only: [:index, :show] do
      resources :locations_integration_settings, only: [:show], defaults: {format: :json}
    end
  end

  resources :locations
  resources :clients_integration_settings
  resources :locations_integration_settings

  root to: "entries#index"
end
