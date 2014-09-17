require "resque/server"

G5Hub::Application.routes.draw do
  mount G5Authenticatable::Engine => '/g5_auth'
  mount Resque::Server, :at => "/resque"

  resources :entries, only: [ :index, :show]
  resources :tags, only: :show
  resources :clients do
    resources :locations, only: [ :index, :show ]
  end

  resources :locations, only: [] do
    resources :integration_settings, only: [ :new, :create, :edit, :update ]
  end
  root to: "entries#index"
end
