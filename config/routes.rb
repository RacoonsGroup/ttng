Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users

  namespace :api do
    resources :projects, except: :all do
      resources :remote_tasks, only: [:index, :show]
    end
  end

  controller :sessions do
    get '/auth/:provider/callback' => 'sessions#create'
  end
  resources :sessions, only: :index
  resources :users, except: [:new, :create, :destroy]


  resources :related_tasks do
    collection do
      get :find
    end

    resources :time_entries, only: [:create, :update, :destroy]
  end

  resources :articles do
    member do
      post :read
      post :unread
    end
  end

  resources :projects do
    resources :comments, except: [:index]
    member do
      get :export
      get :to_google_drive
    end
  end

  resources :contacts
  resources :customers

  wiki_root '/wiki/all'
  root to: 'welcome#show'
end
