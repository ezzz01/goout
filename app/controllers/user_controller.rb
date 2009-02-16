class UserController < ApplicationController

  def index
  end

  def register
    @title = "Register"
    if request.post? and params[:user]
      @user = User.new(params[:user])
      if @user.save
        session[:user_id] = @user.id
        flash[:notice] = "User #{@user.username} created"
        redirect_to :action => "index"
      end
    end
  end

  def login
    @title = "Login"
    if request.post? and params[:user]
      @user = User.new(params[:user])
      user = User.find_by_username_and_password(@user.username, @user.password)
      if user
        session[:user_id] = user.id
        flash[:notice] = "User #{user.username} logged in"
        redirect_to :action => "index"
      else
        @user.password = nil
        flash[:notice] = "Invalid username/password combination"
      end
  end
  end

end
