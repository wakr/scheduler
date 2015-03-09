Rails.application.routes.draw do
  resources :assignments

  resources :tasks

  resources :users

  root :to => "users#index"

end
