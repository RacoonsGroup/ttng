Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :users, except: [:show, :new, :create]
    resources :customers, except: [:show]
    resources :projects, except: [:show]
  end

  resources :tasks

  root to: 'welcome#show'
end
