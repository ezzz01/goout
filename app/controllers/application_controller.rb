# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_filter :setup_url_generator
  after_filter :teardown_url_generator
  session :session_key => 'iloveyou_here_have_a_cookie'
  helper :all # include all helpers, all the time

  helper_method :current_user   

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery

# def check_authorization
#   authorization_token = cookies[:authorization_token]
#   if authorization_token and not logged_in?
#     user = User.find_by_authorization_token(authorization_token)
#     user.login!(session) if user
#   end
# end

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

  rescue_from CanCan::AccessDenied do |exception|
      flash[:error] = t(:no_permission)
      redirect_to root_url
    end

  def load_organizations(country_id)
    universities = University.find_all_by_country_id(country_id, :conditions => ["pending = ? OR added_by = ?", 0, session[:user_id] ], :order => 'concepts.type, concepts.title'  )
    companies = Company.find_all_by_country_id(country_id, :conditions => ["pending = ? OR added_by = ?", 0, session[:user_id] ], :order => 'concepts.type, concepts.title'  )
    ngos = Ngo.find_all_by_country_id(country_id, :conditions => ["pending = ? OR added_by = ?", 0, session[:user_id] ], :order => 'concepts.type, concepts.title'  )
   
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

  protected

  def setup_url_generator
    PageRenderer.setup_url_generator(UrlGenerator.new(self))
  end

  def teardown_url_generator
    PageRenderer.teardown_url_generator
  end

  private   

  def current_user_session   
    puts @current_user_session.inspect
    return @current_user_session if defined?(@current_user_session)   
    @current_user_session = UserSession.find   
  end   
  
  def current_user   
    @current_user = current_user_session && current_user_session.record   
  end   

end
