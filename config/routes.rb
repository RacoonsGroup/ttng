Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :users, except: [:show, :new, :create]
    resources :customers, except: [:show]
    resources :projects do
      resources :project_infos, except: :index
    end
    resources :days, except: [:show]
  end

  resources :tasks do
    collection do
      get :find
    end

    resources :time_entries, only: :create
  end

  resources :articles do
    member do
      post :read
      post :unread
    end
  end

  resources :projects, only: [:index, :show]

  root to: 'welcome#show'
end
