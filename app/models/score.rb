class Score < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable
  
  def self.questionscore(user_id)
    @total = Score.find_by_sql('select sum(score) score from scores where score = 20 and user_id='+user_id.to_s)
    if @total[0].score != nil
      return @total[0].score
     
    else
       return 0
    end
  end

  def self.answerscore(user_id)
      @total = Score.find_by_sql('select sum(score) score from scores where score = 30 and user_id='+user_id.to_s)
    if @total[0].score != nil
      return @total[0].score

    else
       return 0
    end
  end

  def self.votescore(user_id)
      @total = Score.find_by_sql('select sum(score) score from scores where score = 5 and user_id='+user_id.to_s)
    if @total[0].score != nil
      return @total[0].score

    else
       return 0
    end

  end

  def self.correctscore(user_id)
      @total = Score.find_by_sql('select sum(score) score from scores where score = 40 and user_id='+user_id.to_s)
    if @total[0].score != nil
      return @total[0].score

    else
       return 0
    end
  end
  
end