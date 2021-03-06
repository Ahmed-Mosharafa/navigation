Navigation::Application.routes.draw do
  resources :magnetic_finger_prints


  resources :magnetics


  get 'finger_prints/loc_view' => 'finger_prints#loc_view'
  post 'localization' => 'finger_prints#localization'
  #magnetic lozalization
  get 'magnetic/loc_view' => 'magnetics#loc_view'
  post 'magnetic/localization' => 'magnetics#localization'

  resources :finger_prints


  resources :wifi_finger_prints_records


  resources :routers


  resources :beacons

  get 'places/metadata' => 'places#metadata'
  get 'places/nearby' => 'places#nearby'
  get 'places/search_metadata' => 'places#search_metadata' 
  get 'places/map_view/' => 'places#map_view'
  resources :places 
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'places#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular  route:
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
