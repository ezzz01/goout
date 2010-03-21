class PostsController < ApplicationController
  require 'feedzirra'

  def index
    @user = find_user(params) 
    @title = t(:blog_posts, :username => @user.username )
    @blog_url = @user.blog_url 

    begin
        Post.update_from_feed(@blog_url, @user.id)
    rescue
        flash[:notice] = t(:could_not_connect) 
    ensure
        if (params[:tag_id])
          @posts = @user.posts.find_tagged_with(params[:tag_id], :order => "created_at DESC", :conditions => "deleted = 0" )
        else
          @posts = Post.find_all_by_user_id(@user.id, :order => "created_at DESC", :conditions => "deleted = 0") 
        end
    end

    @tags = @user.posts.tag_counts

    respond_to do |format|
      format.html 
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

  def mark_as_deleted
    @post = Post.find(params[:post_id])
    if @post.update_attribute(:deleted, 1)
      respond_to do |format|
        format.js
      end
    end
  end
end
