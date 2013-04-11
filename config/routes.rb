Roomie::Application.routes.draw do

  resources :messages


  resources :shopping_list_items


  resources :shopping_lists

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # route to join a dwelling using an invite url
  match 'invites/:token/accpet' => 'invites#accept', :as => 'invites_accept'
  match 'invites/:token' => 'invites#show', :as => 'invites'

	# Dwellings
  resources :dwellings do
    resources :invites, :controller => 'dwelling_invites', :except => [:show]
  end

	# Chores
  resources :chores

	# Events
  resources :events

	# Bills
  get 'payments' => 'bill_payments#history', :as => 'history'

  resources :bills do
    resources :bill_payments
  end

	# Shopping Lists
  resources :shopping_lists do
    resources :shopping_list_items
  end


	# Users and signup
  get 'signup' => 'users#new', :as => 'signup'
  resources :users, :except => :index


	# Login / Logout
  get 'logout' => 'sessions#destroy', :as => 'logout'
  get 'login' => 'sessions#new', :as => 'login'
  resources :sessions, :except => [:index, :edit]

  root :to => 'dashboard#index'

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
