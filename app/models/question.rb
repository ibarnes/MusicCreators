class Question < ActiveRecord::Base
  belongs_to :user
  has_one :topic
  has_many :comments
  acts_as_friendly_param :headline
  validates_presence_of :headline
  validates_presence_of :body
  acts_as_taggable
  cattr_reader :per_page
  @per_page = 25


  def self.findanswers(questionid)
    @sql ="select count(rating) rating,questionid,parentid,questions.id id,questions.created_at created_at,body,"+
      "questions.user_id,questions.headline,questions.correct_flag from ratings right join questions on " +
      "questionid = questions.id where parentid="+ questionid + " and correct_flag = 0 group by(id)order by rating desc"
    Question.find_by_sql(@sql)
  end

  def self.findcorrectanswers(questionid)
    @correctsql ="select count(rating) rating,questionid,parentid,questions.id id,questions.created_at created_at,body,"+
      "questions.user_id,questions.headline,questions.correct_flag from ratings right join questions on " +
      "questionid = questions.id where parentid="+ questionid + " and correct_flag = 1 group by(id)order by rating desc"
    Question.find_by_sql(@correctsql)
  end
  
  def self.top_questions
    @topsql = 'select count(rating) rating,questionid,parentid,questions.id id,questions.created_at created_at,body,'+
      'questions.user_id,questions.headline,questions.correct_flag,topic_id '+
      'from ratings right join questions on questionid = questions.id where parentid =0 group by(id)order by rating desc'
    Question.find_by_sql(@topsql)
  end

 
  def self.findparent(id)
    @parentsql = 'select * from questions where id=' + id.to_s
    Question.find_by_sql(@parentsql)
  end
 
end