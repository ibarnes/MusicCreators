class AvatarController < ApplicationController
before_filter :login_required
  def create
    #@avatar = Avatar.new(params[:avatar])
    @avatar = current_user.build_avatar(params[:avatar])
    if @avatar.save
       redirect_to editprofile_path(:user => current_user.login)
       else
          flash[:notice] = 'Profile Image was not successfully updated.'
    end
  end

  #def edit
    #@avatar = current_user.build_avatar(current_user.id)
    
   # @avatar = current_user.build_avatar(params[:avatar])
    #@avatar.save
    #flash[:notice] = 'Profile Image was successfully updated.'
    #redirect_to editprofile_path(:user => current_user.login)
  #end
end
