task :scores => :environment do
  @allusers = User.find(:all)

  @allusers.each do |user|
     #Inserts scores for user's answers
    @answers = Question.find_by_sql('select * from questions WHERE user_id='+user.id.to_s+ ' and parentid != 0')
         
         @answers.each do
             @score = Score.new(:user_id=> user.id, :score => 30)
             @score.save
          end
      
      #Inserts scores for user's correct answers
    @correctanswers = Question.find_by_sql('select * from questions where user_id='+user.id.to_s+
        ' and parentid != 0 and correct_flag=1')
   
        @correctanswers.each do
          @score = Score.new(:user_id=> user.id, :score => 40)
          @score.save
        end
   


    #Inserts scores for user's votes
    @votes = Question.find_by_sql('select *  from  ratings r,questions q where
       r.questionid = q.id and q.user_id='  +user.id.to_s)
   
        @votes.each do
          @score = Score.new(:user_id=> user.id, :score => 5)
          @score.save
        end
   
  end
end