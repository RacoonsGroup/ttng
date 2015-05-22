Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    resources :projects, except: :all do
      resources :remote_tasks, only: [:index, :show]
    end
  end

  namespace :admin do
    resources :users, except: [:show, :new, :create]
    resources :customers, except: [:show]
    resources :contacts
    resources :projects do
      resources :comments, except: :index
      member do
        get :export
        get :to_google_drive
      end
    end
    resources :days, except: [:show]
  end
  controller :sessions do
    get '/auth/:provider/callback' => 'sessions#create'
  end
  resources :sessions, only: :index
  resources :users, only: :index

  
  resources :related_tasks do
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

  resources :projects, only: [:index, :show] do
    resources :comments, except: [:index]
  end

  resources :contacts
  resources :customers

  root to: 'welcome#show'
end
