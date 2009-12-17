ActionController::Routing::Routes.draw do |map|
  map.resources :questions # :path_prefix => ":user"

  map.resources :sessions

  map.resource :session

  map.resources :profiles

  map.resources :discussion

 

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
   map.root :controller => "home"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  #map.search 'search/search', :controller => 'account', :action => 'live_search'
  map.connect 'account/login', :controller => 'account', :action => 'login'
  map.resources :sessions
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'

  map.search '/search/:char', :controller => 'home',:action => 'search', :char => 'A'
  map.tags "/tag/", :controller => 'home', :action => 'tags'
  map.connect '/beta/home', :controller => 'home'
  map.showuser ":user", :controller => 'profiles', :action => 'index'
  map.showprofile ":user/", :controller => 'profiles', :action => 'show'
  map.editprofile ":user/edit", :controller => 'profiles', :action => 'edit'
  map.addavatar "avatar/create", :controller => 'avatar', :action => 'create'
  map.questionreply "/question/reply/:id", :controller =>'questions', :action => 'reply'
  map.vote "/question/vote/:id", :controller =>'questions', :action => 'vote'
  map.deletecomment "comment/:id", :controller=>'questions', :action=>'destroy_comment'

end
