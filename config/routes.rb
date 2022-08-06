# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: :create
  resources :pets, only: %i[index show create]

  namespace :api do
    namespace :v1, format: 'json' do
      resources :users, only: :create
      resources :pets, only: %i[index show create]
    end
  end

  get 'openapi.yaml', to: 'schema#openapi'
  get 'rapidoc.html', to: 'schema#rapidoc'
end
