task :notifications => :environment do
  @allusers = User.find(:all)

  if(@allusers.size > 0)

      @allusers.each do |user|
        @i = 1
       user.notifications = Notification.find(:all)
       user.save
        @i = @i+1
      end
  end

end