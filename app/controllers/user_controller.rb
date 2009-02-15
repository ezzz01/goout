class UserController < ApplicationController

  def index
  end

  def register
    @title = "Register"
    if request.post? and params[:user]
      @user = User.new(params[:user])
      if @user.save
        flash[:notice] = "User #{@user.username} created"
        redirect_to :action => "index"
      end
    end
  end
end
