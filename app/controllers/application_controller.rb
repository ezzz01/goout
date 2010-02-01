# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_filter :check_authorization
  session :session_key => 'iloveyou_here_have_a_cookie'
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery

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

  def load_organizations(country_id)
    universities = University.find_all_by_country_id(country_id, :conditions => ["pending = ? OR added_by = ?", 0, session[:user_id] ], :order => 'organizations.type, organizations.title'  )
    companies = Company.find_all_by_country_id(country_id, :conditions => ["pending = ? OR added_by = ?", 0, session[:user_id] ], :order => 'organizations.type, organizations.title'  )
    ngos = Ngo.find_all_by_country_id(country_id, :conditions => ["pending = ? OR added_by = ?", 0, session[:user_id] ], :order => 'organizations.type, organizations.title'  )
   
    unis = Hash.new
    if universities.length > 0 
        temp = universities.each { |uni| 
            unis[uni.title] = uni.id }
    end

    comps = Hash.new
    if companies.length > 0
        temp = companies.each { |comp| 
            comps[comp.title] = comp.id }
    end

    ngoss = Hash.new
    if ngos.length > 0 
        temp = ngos.each { |ngo| 
            ngoss[ngo.title] = ngo.id }
    end

    orgs = Hash.new
    orgs[t(:university)] = unis unless unis.empty?
    orgs[t(:company)] = comps unless comps.empty? 
    orgs[t(:ngo)] = ngoss unless ngoss.empty?

    orgs
  end


end
