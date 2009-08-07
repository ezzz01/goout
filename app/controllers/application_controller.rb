# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_filter :check_authorization
  session :session_key => 'iloveyou_here_have_a_cookie'
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery  :secret => '23cb6b1336875tf9611218c6ca7276bd'

  def check_authorization
    authorization_token = cookies[:authorization_token]
    if authorization_token and not logged_in?
      user = User.find_by_authorization_token(authorization_token)
      user.login!(session) if user
    end
  end

  def param_posted?(sym)
    request.post? and params[sym]
  end

  def protect
    unless logged_in? 
      session[:protected_page] = request.request_uri
      flash[:notice] = "Please login"
      redirect_to :controller => "user", :action => "login"
      return false
    end
  end

end
