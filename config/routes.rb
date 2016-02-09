require 'api_constraints'

Rails.application.routes.draw do

  devise_for :clients
  # Api definition
  namespace :api, defaults: { format: :json } do
    scope module: :v1,
      constraints: ApiConstraints.new(version: 1, default: true) do
      # We are going to list our resources here
      resources :clients, :only => [:show, :create, :update, :destroy]
      resources :sessions, :only => [:create, :destroy]
      resources :hotels, :only => [:show, :index]
    end
  end
end
