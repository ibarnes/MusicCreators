class RpxController < ApplicationController
 # user_data
# found: {:name=>'John Doe', :username => 'john', :email=>'john@doe.com', :identifier=>'blug.google.com/openid/dsdfsdfs3f3'}
# not found: nil (can happen with e.g. invalid tokens)
def rpx_token
  raise "hackers?" unless data = RPXNow.user_data(params[:token])
  self.current_user = User.find_by_identifier(data[:identifier]) || User.create!(data)
  redirect_to '/'
end

# raw request processing
RPXNow.user_data(params[:token]){|raw| {:email=>raw['profile']['verifiedEmail']} }

# raw request with extended parameters (most users and APIs do not supply them)
RPXNow.user_data(params[:token], :extended=>'true'){|raw| ...have a look at the RPX API DOCS...}

end
