class RatingController < ApplicationController

  #def rate
   # @user = User.find(params[:id])
#    @question = Question.find(params[:question])
#    Rating.delete_all(["rateable_type = 'User' AND rateable_id = ? AND user_id = ? and questionid=?",
#      @user.id, current_user.id, question.id])
#    @user.add_rating Rating.new(:rating => params[:rating],
#      :user_id => current_user.id)
#  end

  def rate
     # return unless logged_in?
      @question = Question.find(params[:question])
      @rated = Rating.find(:all, :conditions=> ["user_id = ? and questionid=?",  current_user.id,@question.id])
      if @rated.size < 1
         #Rating.delete_all(["user_id = ? and questionid=?",  current_user.id, @question.id])
         @rating = Rating.new(:user_id => current_user.id, :questionid => @question.id)
         @rating.save
      else
        flash[:notice] = 'You already voted thank you'
      end
       
  end
end
