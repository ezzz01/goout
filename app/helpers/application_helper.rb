# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # create link for navigation
  def nav_link(text, controller, action="index")
    link_to_unless_current text, :controller => controller, :action => action
  end

  # true if user logged in, false otherwise
  def logged_in?
    not session[:user_id].nil?
  end

end
