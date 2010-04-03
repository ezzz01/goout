class PostsController < ApplicationController
  require 'feedzirra'

  def index
    @user = find_user(params) 
    @title = t(:blog_posts, :username => @user.username )
    @blog_url = @user.blog_url 

    if (params[:tag_id])
        @posts = @user.posts.find_tagged_with(params[:tag_id], :order => "created_at DESC", :conditions => "deleted = 0" )
    else
        @posts = Post.find_all_by_user_id(@user.id, :order => "created_at DESC", :conditions => "deleted = 0") 
    end

    @tags = @user.posts.tag_counts

    respond_to do |format|
      format.html 
    end
  end

  def show
    @post = Post.find(params[:id])
    @tags = @post.tag_list
    @title = @post.user.username + " - " + @post.title
    if params[:mode] == "comment"
      @comment = Comment.new(:user => current_user) 
    end
    respond_to do |format|
      format.html 
    end
  end

  def new
    @post = Post.new
    @title = "Add new post"
    respond_to do |format|
      format.html
    end
  end

  def edit
    @post = Post.find(params[:id])
    @title = "Edit #{@post.title}"
  end

  def create
    @post = Post.new(params[:post])
    @post.user_id = params[:user_id]
    respond_to do |format|
      if @post.duplicate? or @post.save 
        flash[:notice] = 'Post was successfully created.'
        format.html { redirect_to user_posts_url(:id => @post.user_id) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to user_post_url(@post.user_id, @post) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(user_posts_url(@post.user_id)) }
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
