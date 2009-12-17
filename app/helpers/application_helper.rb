# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  include TagsHelper

  def show_avatar
    if @user.avatar
      return @user.avatar.public_filename
    else
      return "no_image.jpg"
    end
  end

  def menu_builder(page_id)
    tabs = ['My Questions','My Answers','Edit Profile Image', 'Edit Profile','Change Password','View Profile']
    content = ""
    tabs.each do |tab|
      content << if page_id == tab
 
        content_tag('li', content_tag('a','By '+tab, :href => nil ), :class => 'active') + " "
      else
        content_tag('li', content_tag('a', 'By '+tab, :href => "search?type="+ tab ), :class => 'inactive') + " "
      end
        
    end
    content_tag(:ul, content, :class => 'tabnav')
  end

  def title(page_title)
    content_for(:title) { page_title }
  end
  
  
  def get_skill(topic_id)
    if topic_id != nil && topic_id.to_i > 0
      @skill = Topic.find(topic_id).title
    else
      @skill = ''
    end
    return @skill
  end

  def find_parent(id)
    @parent = Question.find_by_id(id)

    return @parent
  end

  def find_topic(id)
    @topic = Topic.find_by_id(id)

    return @topic
  end

  def makeplural(num,word)
    if num > 1
      @newword = word + 's'
    else
      @newword = word
    end

  end
  def rpx_signin_url
    dest = url_for :controller => :rpx, :action => :login_return, :only_path => false
    @rpx.signin_url(dest)
  end

  def rpx_associate_url
    dest = url_for :controller => :rpx, :action => :associate_return, :only_path => false
    @rpx.signin_url(dest)
  end

  def widget_url
    BASE_URL + '/openid/v2/widget'
  end

   def scores
      
      Score.find_by_sql('SELECT Distinct(user_id) userid,(select sum(score) from scores s where s.user_id = userid) score FROM scores order by score desc')
   end

    def memberscore(user)
      @scores = scores

      @scores.each do |onescore|
        if onescore.userid.to_s == user.id.to_s

          @score  = onescore.score
        end
      end
      return @score
   end

   def memberrank(user)
      @scores = scores
      @score = ""
      @scores.each_with_index do |onescore, index|
        if onescore.userid.to_s == user.id.to_s
          @rank =  index + 1

        end
      end
         return @rank
   end

   def ordinalize(value)

      case value.to_s
        when /^[0-9]*[1][0-9]$/
          suffix = "th"
        when /^[0-9]*[1]$/
          suffix = "st"
        when /^[0-9]*[2]$/
          suffix = "nd"
        when /^[0-9]*[3]$/
          suffix = "rd"
        else
          suffix = "th"
      end

      return value.to_s << suffix
    end

end