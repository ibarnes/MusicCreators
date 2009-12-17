class ProfilesController < ApplicationController
  require 'will_paginate'
  # GET /profiles
  # GET /profiles.xml
  def index
    # @profile = Profile.find(params[:id])
    @pro =Profile.find_by_user_id(@user.id)
    @questions = @user.questions.recent
    #respond_to do |format|
    #  format.html # index.html.erb
    # format.xml  { render :xml => @profiles }
    #end
  end


  # GET /profiles/1
  # GET /profiles/1.xml
  def show
    #@profile = Profile.find(params[:id])
    @profile = Profile.find_by_user_id(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @profile }
    end
  end



  # GET /profiles/new
  # GET /profiles/new.xml
  def new
    if logged_in?
      @profile = Profile.new
      @profile.id = current_user.id
      @avatar = current_user.build_avatar(params[:avatar])
      @avatar.save
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @profile }
      end
    else
      flash[:notice] = 'You must login!'
      redirect_to :controller => 'account', :action => 'login'
    end
  end


  # GET /profiles/1/edit
  def edit

    if logged_in?
      @us = User.find(current_user.id)
      @profile = @us.profile
      @avatar = @user.avatar
      @edituser = @us
      
      if params[:current] != nil
      	
      	@profile.attributes = params[:profile]
      	@profile.save
      	#@current = params[:current]
      	#@edituser.mostExperienced = @current["mostExperienced"]
   	if @us.update_attributes(params[:current])
   	
		flash[:notice] =  ''

		redirect_to editprofile_path
        else
		flash[:notice] =  'Your profile did not update'
	   	
		redirect_to editprofile_path
        end
     
      end  
    else

      redirect_to :controller => 'account', :action => 'login'
    end
    
  end
  
  

  def answers
    if logged_in?
      @pageid = 1
      @answers = Question.find_by_sql('Select * from questions where parentid != 0 and user_id =' + current_user.id.to_s)
      @answers = Question.paginate @answers,:page => params[:page], :order => 'created_at DESC', :per_page => 20
    else

      redirect_to :controller => 'account', :action => 'login'
    end
  end


  def questions
    if logged_in?
      @pageid = 0
      @questions = Question.find_by_sql('Select * from questions where parentid = 0 and  user_id =' + current_user.id.to_s)
      @questions = Question.paginate @questions,:page => params[:page], :order => 'created_at DESC', :per_page => 20
    else

      redirect_to :controller => 'account', :action => 'login'
    end

  end

  def notifications
    
    if logged_in?
      @notification = Notification.find(:all)      
      if params[:person] != nil
        @person = User.find(current_user)
        
        if @person.update_attributes params[:person]
            flash[:notice] = "Settings have been saved."
            redirect_to notifications_url(@person.id)
        else
            flash.now[:error] = @person.errors
            setup_form_values
            respond_to do |format|
                format.html { render :action => "notifications"}
            end
        end
     end
    else
        redirect_to :controller=> 'account', :action => 'login'
    end
  end


  # POST /profiles
  # POST /profiles.xml
  def create
    @profile = Profile.new(params[:profile])

    respond_to do |format|
      if @profile.save
        flash[:notice] = 'Profile was successfully created.'
        format.html { redirect_to(editprofile_path(current_user.login))}
        format.xml  { render :xml => @profile, :status => :created, :location => @profile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /profiles/1
  # PUT /profiles/1.xml
  def update
    @profile = current_user.profiles

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
      
        flash[:notice] = 'Profile was successfully updated.'
        format.html { redirect_to(@profile) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.xml
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to(profiles_url) }
      format.xml  { head :ok }
    end
  end

 
   def feeds
   	
   end

end