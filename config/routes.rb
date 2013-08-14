Parentportal::Application.routes.draw do
  
  get "about/index"
  get "about/more"
  get "about/pricing"
  get "about/contact"
  get "about/thankyou"
  get "about/trial_thankyou"
  post "about/contact_action"
  get "about/trial"
  post "about/trial_action"
  get "about/features"

  resources :children do
    resources :entries

    match 'journal' => 'children#journal'
    match 'profile_photo' => 'children#profile_photo'
    match 'profile_photo_action' => 'children#profile_photo_action'
  end
  
  resources :school_classes

  get "home/index"


  get "account/register"
  get "account/login"
  get "account/logout"
  get "account/updatepassword"
  get "account/forgotpassword"
  get "account/forgotpassword_sent"
  get "account/forgotpassword_return"
  post "account/register_action"
  post "account/login_action"
  post "account/updatepassword_action"
  post "account/forgotpassword_action"
  post "account/forgotpassword_update"
  post "account/forgotpassword_updateaction"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)
  match 'home' => 'home#index', :as => :home
  match 'account/login' => 'account#login', :as => :login
  match 'account/logout' => 'account#logout', :as => :logout
  match 'account/forgotpassword' => 'account#forgotpassword', :as => :forgotpassword
  match 'children/:id/journal' => 'account#forgotpassword', :as => :journal
  match 'children/:id/profile_photo' => 'account#profile_photo', :as => :profile_photo
  match 'children/:id/profile_photo_action', to: 'photos#profile_photo_action', via: [:post]

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
  namespace :admin do
    resources :users
    resources :user_roles
    resources :roles
    resources :schools
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'about#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
