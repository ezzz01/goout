class AdminController < ApplicationController

  def index
    admin = Role.find_by_title('admin')
    
    if !current_user.roles.include?(admin)
      flash[:notice] = t(:no_permission)
      redirect_to root_path 
    end

  end

end
