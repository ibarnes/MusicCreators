# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  #helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  #protect_from_forgery # :secret => '6c80b8feee6ea6e0f66d6479226401c1'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  session :session_key => '_beatcreators_session_id'
  include AuthenticatedSystem
  before_filter :login_from_cookie
 # before_filter :require_login
  before_filter :get_user
  

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to :controller => 'account', :action => 'login' # halts request cycle  end  end
    end
  end
    protected
    def get_user
      if !(@user = User.find_by_login(params[:user]))
        #redirect_to :controller => 'welcome', :action => 'directory'
      end
    end
    
    def get_users_to_be_notified(type)
    	i=0
    	@tobenotified = Notification.find_by_sql('SELECT user_id FROM notifications_users where notification_id = ' + type.to_s)
    	@newusers = Array.new(@tobenotified.size)
    	@tobenotified.each do |notified|
    	@newusers[i] = User.find(notified.user_id).email
    	i += 1
    end

    return @newusers
  end

  def get_user_to_be_notified(type,user)

    @tobenotified = Notification.find_by_sql('SELECT user_id FROM notifications_users where notification_id = ' + type.to_s + ' and user_id=' + user.id.to_s)
    return @tobenotified
  end
  
   def score(user,score)
       @score = Score.new(:user_id=> user.id, :score => score)
       @score.save

    end
  
  end