class UserMailer < ActionMailer::Base
  
def forgot_password_confirmation(user)
  recipients  user.email
  from        "webmaster@beatcreators.com"
  subject     "Reset your password"
  body        :user => user
end
end
