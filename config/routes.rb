Rails.application.routes.draw do
  resources :groups

  resources :assignments

  resources :tasks

  resources :users

  root :to => "users#index"

  resources :memberships, only: [:new, :create, :destroy]
end
