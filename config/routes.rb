Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root to: 'connections#index'

  resources :connections, only: [:index, :new, :destroy] do
    member do
      get :refresh
      get :reconnect
    end
  end
end
