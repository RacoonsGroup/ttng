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
      post :event
    end
  end

  resources :contacts
  resources :customers
  resources :common_comments

  resources :categories do
    collection do
      get :manage
      # required for Sortable GUI server side actions
      post :rebuild
    end
  end

  post 'contacts/add_new_comment' => 'contacts#add_new_comment'
  post 'customers/add_new_comment' => 'customers#add_new_comment'
  get 'wiki' => 'wiki_pages#all'
  post 'wiki' => 'wiki_pages#create'
  post '/wiki/:title' => 'wiki_pages#update'
  wiki_root '/wiki'
  root to: 'welcome#show'
end
