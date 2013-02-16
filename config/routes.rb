WarmUpProj::Application.routes.draw do
  get "testapi/unit_test"

  get "testapi/reset_fixture"

  get "users/add"

  get "users/login"

  get "sign_up_page/client"

  #link to the controller, from webpage to the controller
  root to: "sign_up_page#client"
  
  #root /sighup path to sign_up_page
  match '/signup', to: 'sigh_up_page#client'

  #links /client.js to the front page js file
  match '/client.js', to: 'sign_up_page#client.js.erb'
  match '/client.css', to: 'sign_up_page#client.css.erb'
  
  #route http request to user_controller add func
  match '/users/add', to: 'users#add', :via => :post, :defaults => {format: "json"}

  #route http request to user_controller login func
  match '/users/login', to: 'users#login', :via => :post, :defaults => {format: "json"}

  #route http test request to user_controller test func's
  match '/TESTAPI/unitTests', to: 'testapi#unit_test', :via => :post, :defaults => {format: "json"}
  match '/TESTAPI/resetFixture', to: 'testapi#reset_fixture', :via => :post, :defaults => {format: "json"}



  # The priority is based upon order of creation:
  # first created -> highest priority.

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

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
