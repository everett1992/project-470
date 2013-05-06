Roomie::Application.routes.draw do

  root :to => 'dashboard#index'

  # route to join a dwelling using an invite url
  match 'invites/:token/accpet' => 'invites#accept', :as => 'invites_accept'
  match 'invites/:token' => 'invites#show', :as => 'invites'

  # Dwellings
  resources :dwellings, except: :index do
    resources :invites, :controller => 'dwelling_invites', :except => [:show, :edit, :update]
  end

  # Bills
  get 'payments' => 'bill_payments#history', :as => 'history'
  resources :bills do
    resources :comments
    resources :bill_payments
  end

  # Shopping Lists
  resources :shopping_lists do
    resources :comments
    resources :shopping_list_items
  end

  # Chores
  put 'chores/:id/deactivate' => 'chores#deactivate', :as => "deactivate_chore"
  resources :chores do
    resources :comments
  end

  # Events
  resources :events do
    resources :comments
  end

  # Comments
  resources :comments do
    resources :comments
  end

  # Posts
  resources :posts do
    resources :comments
  end

  # Users and signup
  get 'signup' => 'users#new', :as => 'signup'
  resources :users, :except => [:index, :edit, :update] do
    member do
      
      [:account, :profile, :picture, :notifications].each do |type|
        get "settings/#{type}" => "user_settings#edit_#{type}", as: "#{type}_settings"
        put "settings/#{type}" => "user_settings#update_#{type}"
      end
    end
  end
  
  # Login / Logout
  get 'logout' => 'sessions#destroy', :as => 'logout'
  get 'login' => 'sessions#new', :as => 'login'
  resources :sessions, :only => [:new, :create, :destroy]

end
