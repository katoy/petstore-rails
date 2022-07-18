Rails.application.routes.draw do
  resources :users, only: :create
  resources :pets, only: %i[index show create]

  get 'openapi.yaml', to: 'schema#openapi'
  get 'rapidoc.html', to: 'schema#rapidoc'
end
