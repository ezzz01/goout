class UserController < ApplicationController
  include ApplicationHelper
  before_filter :protect, :only => "index"

  def index
    @title = "User profile"
  end

  def register
    @title = "Register"
    if param_posted?(:user) 
      @user = User.new(params[:user])
      if @user.save
        @user.login!(session) 
        flash[:notice] = "User #{@user.username} created"
        redirect_to_forwarding_url
      else 
        @user.clear_password!
      end
    end
  end

  def login
    @title = "Login"
    if request.get?
      @user = User.new(:remember_me => cookies[:remember_me] || "0")
    elsif param_posted?(:user)
      @user = User.new(params[:user])
      user = User.find_by_username_and_password(@user.username, @user.password)
      if user
        user.login!(session) 
        if @user.remember_me == "1"
          cookies[:remember_me] = { :value => "1", :expires => 4.months.from_now }
        end
        flash[:notice] = "User #{user.username} logged in"
        redirect_to_forwarding_url
      else
        @user.clear_password!
        flash[:notice] = "Invalid username/password combination"
      end
    end
  end

  def logout
    User.logout!(session)
    flash[:notice] = "Logged out"
    redirect_to :action => "index", :controller => "Site"
  end

  private 
  def protect
    unless logged_in? 
      session[:protected_page] = request.request_uri
      flash[:notice] = "Please login"
      redirect_to :action => "login"
      return false
    end
  end

  def param_posted? (symbol)
    request.post? and params[symbol]
  end

  def redirect_to_forwarding_url
    if (redirect_url = session[:protected_page])
      session[:protected_page] = nil
      redirect_to redirect_url
    else
      redirect_to :action => "index"
    end
  end

end
