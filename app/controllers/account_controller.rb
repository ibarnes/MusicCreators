class AccountController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  # If you want "remember me" functionality, add this before_filter to Application Controller
  before_filter :login_from_cookie
  skip_before_filter :get_user
  # say something nice, you goof!  something sweet.
  def index
    redirect_to(:action => 'signup') unless logged_in? || User.count > 0
  end

  def login
    return unless request.post?
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
    
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      if Profile.exists?(["user_id =?",current_user.id])
        @profile = Profile.new(:user_id => current_user.id)
      	@profile.save
        if current_user.paid == 1
      	redirect_to(myquestions_path(current_user.login) )
        else
          redirect_to signup_path
        end
      else
        @profile = Profile.new(:user_id => current_user.id)
      	@profile.save
        if current_user.paid == 1
        redirect_to(myquestions_path(current_user.login) )
         else
          redirect_to signup_path
        end
      end
      
     


    else
      @notice = "Log in unsuccessful because of the username/password you entered! Try again."
    end
  end

  def forgot_password

    if params[:email] != nil
      if User.exists?(["email =?",params[:email]])
        @user = User.find_by_email(params[:email])
        @user.resetcode = Digest::SHA1.hexdigest(Time.now.to_s.split(//).sort_by{rand}.join)
        @user.save
        UserMailer.deliver_forgot_password_confirmation(@user)
        flash[:notice] = "Your password has been sent to your email address!"
        redirect_to(:action => 'signup')
      else
        flash[:notice] = "Please enter your correct email address."
      end
    end
  end


  def signup
    @user = User.new(params[:user])
    return unless request.post?
    @user.save!
    UserMailer.deliver_new_member(@user)
    self.current_user = @user
    
    redirect_to signup_path
    
  rescue ActiveRecord::RecordInvalid
    render :action => 'signup'
  end
  
  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice1] = ""
    redirect_back_or_default(:controller => '/account', :action => 'login')
  end

  def live_search

    @phrase = request.raw_post || request.query_string
    a1 = "%"
    a2 = "%"
    @searchphrase = a1 + @phrase + a2
    @results = User.find(:all, :conditions => [ " users LIKE ? ", @searchphrase])

    @number_match = @results.length

    render(:layout => false)
  end


  def change_password
    if current_user.authenticated?(params[:old_password])
      current_user.password = params[:password]
      current_user.password_confirmation = params[:password_confirmation]
      begin
        current_user.save!
        flash[:notice] = 'Successfully changed your password.'
        redirect_to(editprofile_path(current_user.login)) 
      rescue ActiveRecord::RecordInvalid => e
        flash[:error] = "Couldn't change your password: #{e}"
        redirect_to(mypassword_path)
      end
    else
      flash[:notice] = "Couldn't change your password: is that really your current password?"
      redirect_to(mypassword_path(current_user))
    end
  end


  def reset
    @user = User.find_by_resetcode(params[:code])
    return unless request.post?
    if @user != nil
	    if(params[:password] != nil || params[:password_confirmation] != nil )
	      if (params[:password] == params[:password_confirmation] )
          # if !@user.nil?
          #   self.current_user = User.authenticate(@user.login, params[:password])
          #end
          @user.password =params[:password]
          @user.password_confirmation = params[:password_confirmation]
          begin
            if  @user.save
              self.current_user = User.authenticate(@user.login, params[:password])
              @message = 'You have successfully changed your password. Now contribute to the site by asking and answering questions.'
              redirect_back_or_default(editprofile_path(@user.login))
            else
              @message = 'Not your password.'
            end
          rescue ActiveRecord::RecordInvalid => e
            flash[:error] = "Couldn't change your password: #{e}"
          end

	      else
          @message = 'Password mismatch'
	      end
	    else
        @message =  'Please enter your new password!'
	    end
	    #redirect_back_or_default(:controller => '/questions', :action => 'index')
	    #  rescue
	    #   logger.error "Invalid Reset Code entered"
	    #  flash[:notice] = "Sorry - That is an invalid password reset code. Please check your code and try again. (Perhaps your email client inserted a carriage return)"
	    # redirect_back_or_default(:controller => '/home', :action => 'index')
	  end
	  
  else
    flash[:notice] = 'That reset code does not exist'
	
  end

end