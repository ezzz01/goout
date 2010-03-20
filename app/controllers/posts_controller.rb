class PostsController < ApplicationController
  include ApplicationHelper

  # GET /posts
  # GET /posts.xml
  def index
    @user = User.find_by_username(params[:user])
    @blog_url = @user.blog_url 

    if (params[:tag_id])
      @posts = User.find(params[:user_id]).posts.find_tagged_with(params[:tag_id])
    else
      @posts = User.find_by_username(params[:user]).posts
      if @blog_url
        @xmlposts = get_xml_feed(@blog_url)
        @posts_and_xml = Array.new
        begin
          @posts_and_xml  = (@posts + @xmlposts).sort {|a, b| b.date <=> a.date}
        rescue
          flash[:notice] = t(:could_not_connect) 
          @posts_and_xml = @posts
        end
      else
        @posts_and_xml = @posts
      end
    end
    
    @tags = User.find_by_username(params[:user]).posts.tag_counts

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts_and_xml }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])
    @tags = @post.tag_list
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
    @post.user_id = params[:user_id]
    respond_to do |format|
      if @post.duplicate? or @post.save 
        flash[:notice] = 'Post was successfully created.'
        format.html { redirect_to user_posts_url(:id => @post.user_id) }
        format.xml  { render :xml => user_posts_url(@post.user_id), :status => :created, :location => post_url(:id => @post) }
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
        format.html { redirect_to user_post_url(@post.user_id, @post) }
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
      format.html { redirect_to(user_posts_url(@post.user_id)) }
      format.xml  { head :ok }
    end
  end


end
