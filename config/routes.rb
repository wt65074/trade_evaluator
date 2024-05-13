Rails.application.routes.draw do
  get 'models/new'
  get 'models/list'
  get 'models/show'
  get 'trade/show'
  get 'trade/new'
  post 'models/new' => 'models#create', as: 'models_create'
  delete 'models/:id/delete' => 'models#delete', as: 'models_delete'
  get 'models/:id/download' => 'models#download', as: 'models_download'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root 'root#index'
end
