Rails.application.routes.draw do
  resources :groups

  resources :assignments

  resources :tasks
  post 'mark_done' => 'tasks#mark_done'

  resources :users

  root :to => 'sessions#new'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  resources :memberships, only: [:new, :create, :destroy]

  resource :session, only: [:new, :create, :delete]

  resources :user_assignments

  get 'welcome', to: 'welcome#index'
end
