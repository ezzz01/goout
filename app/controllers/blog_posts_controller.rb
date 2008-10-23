class BlogPostsController < ApplicationController
  # GET /blog_posts
  # GET /blog_posts.xml
  def index
    @blog_posts = BlogPost.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @blog_posts }
    end
  end

  # GET /blog_posts/1
  # GET /blog_posts/1.xml
  def show
    @blog_post = BlogPost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @blog_post }
    end
  end

end
