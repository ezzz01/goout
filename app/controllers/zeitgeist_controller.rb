class ZeitgeistController < ApplicationController

  def index

  @user = nil
  @tags = Post.tag_counts

  if (params[:tag])
    @posts = Post.find_tagged_with(params[:tag], :order => "created_at DESC", :conditions => "deleted = 0" )
    @posts = @posts.paginate(:page => params[:page], :per_page => 15)
  else
    @posts = Post.paginate(:order => 'created_at DESC', :page => params[:page], :per_page => 15, :conditions => "deleted = 0") 
  end
    respond_to do |format|
      format.html
    end
  end
end
