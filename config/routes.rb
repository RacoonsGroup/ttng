Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :users, except: [:show, :new, :create]
  end

  root to: 'welcome#show'
end
