#skip_before_filter :verify_authenticity_token, :only => [:auto_complete_for_message_to]  
class QuestionsController < ApplicationController
  require 'will_paginate'

  # GET /questions
  # GET /questions.xml
  def index
    
    @questions = Question.paginate  :page => params[:page], :order => 'created_at DESC'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.xml
  def show
    @question = Question.find(params[:id])
    @avatar  = Avatar.find_by_user_id(@question.user_id)
    @user = User.find(@question.user_id)
    @answers  = Question.findanswers(@question.id.to_s)
    @correctanswers = Question.findcorrectanswers(@question.id.to_s)
    @totalanswers = @answers.size + @correctanswers.size
	  if current_user == @user
      @asker = true
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.xml
  def new
    if logged_in?
      @question = Question.new
      @question.correct_flag=0
      @topics = Topic.find_by_sql('Select * from topics order by title asc')
     if params[:question_headline] != nil
       @text = params[:question_headline]
     end
      respond_to do |format|
      format.html # new.html.erb
        #format.xml  { render :xml => @question }
       #format.js  # new.js.erb
     #  redirect_to :controller => 'questions', :action => 'new'
     end
    else
     # flash[:notice] = 'You must login or create an account to ask a question.'
      redirect_to :controller => 'account', :action => 'login'
    end
    #@question = current_user.question.build
  end

  # GET /questions/new
  # GET /questions/new.xml
  def reply
    if logged_in?
      if params[:reply]
        @reply = Question.new(params[:reply])
        @reply.correct_flag=0
        @reply.user_id = current_user.id
        @reply.save
        @user = current_user
        @parent = Question.find(@reply.parentid)
        @answers  = Question.findanswers(@parent.id.to_s)
        @answer = Question.find_all_by_id(@reply.id)
        respond_to do |format|
          flash[:notice] = 'Your answer was submitted successfully.'
          format.js
          format.html { redirect_to(question_path(@parent))}
          format.xml  { render :xml => @reply }
        end
      end
    else
      flash[:notice] = 'Your must login or create an account to reply to a question.'
      redirect_to :controller => 'account', :action => 'login'
    end
  end

  # GET /questions/new
  # GET /questions/new.xml
  def comment
    if logged_in?
      if params[:comment]
        @comment = Comment.new(params[:comment])
        @comment.user_id = current_user.id
        @comment.save
        @user = current_user
        @parent = Question.find(@comment.parent_id)
        respond_to do |format|
          flash[:notice] = 'Your comment was submitted successfully.'
        
          format.html { redirect_to(:back)}
          format.xml  { render :xml => @comment }
        end
      end
    else
      flash[:notice] = 'Your must login or create an account to comment to a question.'
      redirect_to :controller => 'account', :action => 'login'
    end
  end

  # DELETE /comment/1
  # DELETE /comment/1.xml
  def destroy_comment
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      flash[:notice] = 'Comment was successfully deleted.'
      format.html { redirect_to(:back) }
      format.xml  { head :ok }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
    @top = nil
    @type = 'Question'
    if @question.parentid > 0
      @top = Question.find_by_id(@question.parentid)
      @headline = @top.headline
      @type = 'Answer'
    end
  end

   # GET /questions/1/edit
  def editanswer
    @question = Question.find(params[:id])
    @top = nil
    @type = 'Question'
    if @question.parentid > 0
      @top = Question.find_by_id(@question.parentid)
      @headline = @top.headline
      @type = 'Answer'
    end
  end

  # POST /questions
  # POST /questions.xml
  def create
    @question = Question.new(params[:question])
    @question.parentid = 0
    @question.correct_flag=0
     @topics = Topic.find_by_sql('Select * from topics order by title asc')
    respond_to do |format|
      if @question.save
        flash[:notice] = 'Question was successfully created.'
        format.html { redirect_to(question_path(@question)) }
        format.js
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.js
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.xml
  def update
    @question = Question.find(params[:id])
    @type = 'Post'
    @top = nil
    if(@question.parentid >0)
      
      @top = Question.find_by_id(@question.parentid)
      @question.headline = '1'
    end
    respond_to do |format|
      if @question.update_attributes(params[:question])
        if(@question.parentid < 1) # if editing a question
          flash[:notice] = 'Question was successfully updated.'
          format.html {  redirect_to(question_path(@question.id))  }
        else #If editing an  answer
          flash[:notice] = 'Answer was successfully updated.'
          format.html { redirect_to(question_path(@question.parentid)) }
        end
      else
        if @question.headline == '1'
         format.html { render :action => "editanswer" }
        else
          format.html { render :action => "edit" }
        end
        
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.xml
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      flash[:notice] = 'Question was successfully deleted.'
      format.html { redirect_to(:back) }
      format.xml  { head :ok }
    end
  end

  def vote
    @value = params[:id]
    @vote = Rating.new()
    @vote.questionid = @value.to_i
    @vote.rateable_type = "1"
    @vote.rateable_id = 1
    @vote.rating = 1
    @vote.user_id = current_user.id
    @vote.save
    # get total rating
    @rating = Rating.find_all_by_questionid(@vote.questionid)
    @total_vote = @rating.size;
    @notice = 'Your vote was successful.'
	  redirect_to(:back)

  end

  # Must meet the following conditions before an answer can be marked as the correct answer
  # 1. Answer is the current user
  # 2. Only one answer can be marked correct

  def correct
    @correct = params[:number]
    @correct = Question.find(@correct.to_i)

    if @correct != nil
      @allanswers  = Question.find(:all, :conditions=>'parentid > 0')
      @parent = Question.find_by_parentid(@correct.parentid)
      if @parent.user_id == current_user.id && @correct.correct_flag != 1 # Checks for condition 1
        # Checks for condition 2
        for answer in @allanswers
         
          if answer.correct_flag == 1
            answer.correct_flag = 0
            answer.save
            #  @correct.update(@correct.id,:correct_flag=>0)
          end
        end
            @correct.correct_flag = 1
          
            @correct.save
         
        #@correct.update(@correct.id,:correct_flag=>1)
        #flash[:notice] = 'Your selection of the correct answer was successful.'
      else
        for theanswer in @allanswers
          if theanswer.correct_flag == 1
            theanswer.correct_flag = 0
            theanswer.save
            #  @correct.update(@correct.id,:correct_flag=>0)
        #    flash[:notice] = 'Your selected correct answer was unselected.'
       
          end
        end
      end
    
      redirect_to(:back)
    else

    
    end
  end

  def tag_cloud
    @tags = Question.tag_counts # returns all the tags used end
  end



  def auto_complete_for_question_tags()
    title = params[:question][:tags]
    @questions = Question.find(:all , :conditions=>"headline like '%"+title.downcase+"%'")
    render :partial => 'headline'
	end


  def related_question_headline
    title = params[:headline]
    
    render :partial => "answers", :locals => { :questions => @questions }
	end  
end
