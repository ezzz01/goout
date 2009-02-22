class SpecController < ApplicationController

  def index
    redirect_to :controller => "user", :action => "index"
  end

  def edit
    @title = "Edit profile information"
    @user = User.find(session[:user_id])
    @user.spec ||= Spec.new
    @spec = @user.spec
    if param_posted?(:spec)
        flash[:notice] = "Changes saved"
      if @user.spec.update_attributes(params[:spec])
        flash[:notice] = "Changes saved"
        redirect_to :controller => "user", :action => "index"
      else
        flash[:notice] = "Could not save"
      end
    end
  end
end
