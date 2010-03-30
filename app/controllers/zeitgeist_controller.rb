class ZeitgeistController < ApplicationController

  def index
    posts = Post.all(:order => "created_at DESC", :limit => 50)
    @posts = posts.paginate(:page => params[:page], :per_page => 10) 

    respond_to do |format|
      format.html
    end
  end
end
