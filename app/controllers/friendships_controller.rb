class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])   
      if @friendship.save   
        flash[:notice] = "Added friend."   
        redirect_to user_path(params[:friend_id]) 
      else   
        flash[:notice] = "Unable to add friend."   
        redirect_to user_path(params[:friend_id]) 
      end   
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])   
    @friendship.destroy   
    flash[:notice] = "Removed friendship."   
    redirect_to user_path(current_user)   
  end

end
