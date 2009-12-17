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


  map.connect 'account/login', :controller => 'account', :action => 'login'
  map.resources :sessions
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.forgot_password "account/forgot_password", :controller=>'account', :action=>'forgot_password'

  map.searchquestions '/search', :controller => 'home',:action => 'search'
  map.editanswer 'questions/editanswer/:id', :controller => 'questions', :action=>'edit'
  map.top '/top', :controller=> 'home', :action=>'top'
  map.leaders '/leaders', :controller=> 'home', :action=>'leaders'
  map.recent '/recent', :controller=> 'home', :action=>'recent'
  map.tags '/tags/', :controller => 'home', :action => 'tags'
  map.tag '/tag/:tag', :controller=> 'home', :action=>'showtag'
  map.faq '/faq', :controller=> 'home', :action=>'faq'
  map.showuser "profile/:user", :controller => 'profiles', :action => 'index'
  #Profile
  map.showprofile "profile/:user", :controller => 'profiles', :action => 'show'
  map.editprofile "profile/:user/edit", :controller => 'profiles', :action => 'edit'
  map.myanswers "profile/:user/edit/answers", :controller => 'profiles', :action => 'answers'
  map.myquestions "profile/:user/edit/questions", :controller => 'profiles', :action => 'questions'
  map.mypassword "profile/:user/edit/reset", :controller => 'profiles', :action => 'reset'
  map.myimage "profile/:user/edit/image", :controller => 'profiles', :action => 'image'
  map.myfeeds "profile/:user/edit/feeds", :controller => 'profiles', :action => 'feeds'
  map.notifications "profile/:user/edit/notifications", :controller=>'profiles', :action=> 'notifications'


  map.addavatar "avatar/create", :controller => 'avatar', :action => 'create'
  map.questionreply "/question/reply/:id", :controller =>'questions', :action => 'reply'
  map.vote "/question/vote/:id", :controller =>'questions', :action => 'vote'
  map.deletecomment "comment/:id", :controller=>'questions', :action=>'destroy_comment'
  map.correctanswer "/question/correct/:number", :controller =>'questions', :action=>'correct'
  map.forgot_password "account/forgot_password", :controller=>'account', :action=>'forgot_password'
  map.resetpassword "/reset/:code", :controller=>'account', :action=>'reset'
  map.reply 'question/reply', :controller =>'questions',:action => 'reply'
  map.questionheadline "/find/related", :controller=>'questions', :action=> 'related_question_headline'
  map.newhome "/homenew", :controller=>'home', :action=> 'home'
  map.topic "/topics/:num", :controller=>'home', :action=>'topics'

end