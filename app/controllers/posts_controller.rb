class PostsController < ApplicationController
  helper :profile
  before_filter :protect, :protect_blog
  # GET /posts
  # GET /posts.xml
  def index
    @posts = @blog.posts
    @post.blog = @blog
    @title = "Blog management"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])
    @title = @post.title
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new
    @title = "Add new post"
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @title = "Edit #{@post.title}"
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @blog.post << @post 
        flash[:notice] = 'Post was successfully created.'
        format.html { redirect_to post_url(:id => @post) }
        format.xml  { render :xml => post_url(:id => @post), :status => :created, :location => post_url(:id => @post) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to post_url(:id => @post) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end

  private

  def protect_blog
    @blog = Blog.find(params[:blog_id])
    user = User.find(session[:user_id])
    unless @blog.user == user
      flash[:notice] = "That isn't your blog!"
      redirect_to posts_url
      return false
    end
  end

end