class DiscussionController < ApplicationController
  before_filter :login_required
  before_filter :find_discussion, :except => [:index, :new, :create]

  def index
    @discussions = current_user.discussions
  end

  def show
  end

  def new
    @discussion = Discussion.new
  end

  def create
    @discussion = current_user.discussions.build(params[discussion])
    if @discussion.save!
    redirect_to(:controller => 'profiles')
    else
    render :action => "new"
    end
  end

  def update
    @discussion.attributes = params[:discussion]
    @discussion.save!
    redirect_to(:action => "index")
   end

  def destroy
  
    @discussion.destroy
    redirect_to(:controller => "homes", :action => "index")
  end
  protected
    def find_discussion()
      @discussion = current_user.discussions.find(params[:id])
    end

end

