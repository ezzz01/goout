class UserController < ApplicationController
  include ApplicationHelper
  helper :profile
  before_filter :protect, :only => ["index", "edit"]

  def index
    @title = "User profile"
    @user = User.find(session[:user_id])
    @user.spec ||= Spec.new
    @spec = @user.spec
  end

  def register
    @title = "Register"
    if param_posted?(:user) 
      @user = User.new(params[:user])
      @user.blog = Blog.new
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
        @user.remember_me? ? user.remember!(cookies) : user.forget!(cookies) 
        flash[:notice] = "User #{user.username} logged in"
        redirect_to_forwarding_url
      else
        @user.clear_password!
        flash[:notice] = "Invalid username/password combination"
      end
    end
  end

  def logout
    User.logout!(session, cookies)
    flash[:notice] = "Logged out"
    redirect_to :action => "index", :controller => "Site"
  end

  def edit
    @title = "Edit basic info"
    @user = User.find(session[:user_id])
    if param_posted?(:user)
      attribute = params[:attribute]
      case attribute
      when "email"
        try_to_update @user, attribute
      when "password"
        if @user.correct_password?(params)
          try_to_update @user, attribute
        else
          @user.password_errors(params)
        end
      end
    end
    @user.clear_password!
  end


  private 

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

  def try_to_update(user, attribute)
    if user.update_attributes(params[:user])
      flash[:notice] = "User #{attribute} updated."
      redirect_to :action => "index"
    end
  end

end
