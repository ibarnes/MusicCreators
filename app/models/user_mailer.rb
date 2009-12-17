class UserMailer < ActionMailer::Base
  
	def forgot_password_confirmation(user)
	  recipients  user.email
	  from        "webmaster@beatcreators.com"
	  subject     "Reset your password"
	  body        :user => user
	end
	
	def new_question(mail_users,user, question)
	  bcc        "ikebarnes@gmail.com"
	  from 	     "webmaster@beatcreators.com"
	  subject    "New question has been added!"
	  body       :user => user, :question => question
	end
	
	def new_answer(user, question)
	  recipients  user.email
	  from 	      "webmaster@beatcreators.com"
	  subject     "Your question has been answered!"
	  body        :user => user, :question => question
	end
	
	def new_member(user)
	  recipients  user.email
	  from 	      "webmaster@beatcreators.com"
	  subject     "Welcome to BeatCreators!"
	  body        :user => user
	end
	
	def new_comment(user, comment, question)
	  recipients  user.email
	  from 	      "webmaster@beatcreators.com"
	  subject     "Your answer has a comment!"
	  body        :user => user, :comment => comment, :question => question
	end
	
	def answer_vote(user,question,type,subject)
	  recipients  user.email
	  from 	      "webmaster@beatcreators.com"
	  subject     subject
	  body        :user => user,  :question => question, :type => type
	end

  	def answer_correct(user,parent)
    	  recipients  user.email
          from        "webmaster@beatcreators.com"
          subject     "Your answer was the right answer"
          body        :user=> user, :parent => parent
        end

end