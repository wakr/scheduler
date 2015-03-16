Rails.application.routes.draw do
  resources :groups

  resources :assignments

  resources :tasks

  resources :users

  root :to => "users#index"
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  resources :memberships, only: [:new, :create, :destroy]

  resource :session, only: [:new, :create, :delete]
end
