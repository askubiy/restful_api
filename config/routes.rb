require 'api_constraints'

Rails.application.routes.draw do

  devise_for :clients
  # Api definition
  namespace :api, defaults: { format: :json } do
    scope module: :v1,
      constraints: ApiConstraints.new(version: 1, default: true) do
      # We are going to list our resources here
      resources :clients, :only => [:show, :create, :update]
      resources :sessions, :only => [:create, :destroy]
      resources :hotels, :only => [:show, :index] do
        resources :rooms, :only => [:show, :index]
      end
      resources :hotel_facilities, :only => [:index]
      resources :rooms, :only => [:show, :index]
      resources :room_facilities, :only => [:index]
      resources :orders, :only => [:create]
      get "search" => "search#search"
    end
  end
end
