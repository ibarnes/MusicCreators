module ProfilesHelper
	
  def user_wants_notification?(notification)
    if current_user # no sense in testing new users that have no languages
        current_user.notifications.include?(notification)
    else
        false
    end
  end
  
end