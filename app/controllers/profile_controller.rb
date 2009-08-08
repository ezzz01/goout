class ProfileController < ApplicationController

  def index
    @title = "Profiles"
  end

  def show
    username = params[:username]
    @user = User.find_by_username(username)
    if @user
      @title = "#{username} profile"
    else
      flash[:notice] = "No user #{username}"
      redirect_to :action => "index"
    end
  end
end
