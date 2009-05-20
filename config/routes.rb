ActionController::Routing::Routes.draw do |map|

  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'

  map.root :controller => 'sessions', :action => 'new'

  map.home '/home', :controller => 'home'

  map.resources :events
  map.resources :people

  #来电,去电
  map.pop_call "/pop/:kind/:dail/:receive/:wavfile/:uniqueid", :controller => 'records', :action => 'create'

  map.resources :kinds
  map.resources :users
  #map.custom '/personal/custom', :controller => 'users', :action => 'custom'
  #修改密码
  map.pass '/pass', :controller => 'users', :action => 'pass'
  map.user_site '/user/site', :controller => 'users', :action => 'site'

  map.resources :departments do |department|
    department.resources :departments, :as => 'children'
  end
  map.resources :logs
  map.resources :notices
  #非admin用户查看公告列表
  map.notice_list '/listnotice', :controller => 'notices', :action => 'list'

  map.resource :session

  map.resources :conversations
  map.searches '/searches', :controller => 'conversations', :action => 'list'
  map.resources :dispatches
  map.resources :workitems
  map.resources :records

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
