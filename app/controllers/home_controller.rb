class HomeController < ApplicationController
  skip_before_filter :get_user
  before_filter :set_up
  require 'will_paginate'

   def index
    #This will return all of the most active questions
    @quests = "SELECT * FROM questions WHERE id IN" +
    " (SELECT parentid FROM questions ORDER BY updated_at DESC) ORDER BY updated_at DESC"

    @allquestions = Question.find_by_sql(@quests)
   
    @i = 0
    
    @questions = Question.paginate @allquestions, :page => params[:page],:order => 'updated_at desc', :per_page => 25

    @users = User.find(:all, :order => "created_at DESC", :limit => 6)
  
    @rssquestions = @allquestions
    @topics = Topic.find(:all, :order =>"title asc")
    
  end
  
  
  def recent
   
    @users = User.find(:all, :order => "created_at DESC", :limit => 6)
    @questions = Question.paginate :page => params[:page],:order => 'created_at desc', :per_page => 50
    @rssquestions = Question.find(:all,:order => 'created_at DESC')
    @topics = Topic.find(:all, :order =>"title asc")
  end
  
  def top
    @quests ="select count(rating) rating,questionid,parentid,questions.id id,questions.created_at created_at,body,"+
      "questions.user_id,questions.headline,questions.correct_flag,topic_id from ratings right join questions on "+
      " questionid = questions.id  group by(id) order by rating desc"
      
    @questions = Question.paginate_by_sql [@quests], :page => params[:page], :per_page => 25
    @topics = Topic.find(:all, :order =>"title asc")
    @users = User.find(:all, :order => "created_at DESC", :limit => 6)
  end

  def leaders
    @leaders = Score.paginate_by_sql 'SELECT Distinct(user_id) userid,(select sum(score) from scores s where s.user_id = userid) score FROM scores order by score desc' , :page => params[:page], :per_page => 25
    
  end

  def topics
    @topic = params[:num]
    @topicquestions = Question.find_all_by_topic_id(Topic.find_by_title(params[:num].gsub(/[-]/, ' ')))
    @title = params[:num].gsub(/[-]/, ' ')
    @users = User.find(:all, :order => "created_at DESC", :limit => 6)
    @questions = Question.paginate @topicquestions, :page => params[:page], :order => 'created_at DESC', :per_page => 25
    @topics = Topic.find(:all, :order =>"title asc")
  end

  def tags
    @letter = params[:char]
    if params[:char]
      @tags = Tag.find(:all, :group=>'name', :conditions=>['name like ?',params[:char] + '%'])
    else
      @tags = Tag.find(:all, :group=>'name')
    end

  end

  def tag
    @alphabet = ('A'..'Z').to_a
    @size = 0
    @mail_user = get_users_to_be_notified(1)
    if params[:id] != nil
     # @tag = Tags.find(:all, 'tag_id=' + params[:id])
      @tagquestions = Question.find_tagged_with(params[:id])
      @questions = Question.paginate @tagquestions, :page => params[:page], :per_page => 15
     @size = @questions.size
    end

  end


  def search
  @users = User.find(:all, :order => "created_at DESC", :limit => 6)
 @topics = Topic.find(:all, :order =>"title asc")
  if params[:question] != nil
    if params[:question].size > 1
      @question = params[:question]
      @page = params[:page]
      
      if @question.length > 0
        @questions = Question.find_by_sql ['Select * from questions where match(headline,body) against(?) and parentid=0',params[:question]]
      else
        @questions = Question.find(:all, 'parentid = 0')
      end
      @size = @questions.size
      @questions = Question.paginate @questions, :page =>@page , :per_page => 15
     else
     @questions = Question.find(:all, 'parentid = 0')
    end
  else
    redirect_to(:controller=>'home', :action=>'index')
  end
  end

  private

  def set_up
    @page_id = 'home'

  end
end