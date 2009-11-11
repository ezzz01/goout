class CommentsController < ApplicationController
 before_filter :load_post, :only => ["index", "show", "new", "create"]

 
  # GET /comments
  # GET /comments.xml
  def index
    redirect_to user_post_path(@post.user_id, @post) 
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    redirect_to user_post_path(@post.user_id, @post) 
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = @post.comments.build
    respond_to do |format|
      format.html { redirect_to user_post_path(@post.user_id, @post) }
      format.xml  { redirect_to user_post_path(@post.user_id, @post)}# render :xml => @comment }
      format.js 
    end
  end

  # POST /comments
  # POST /comments.xml
  def create
    @comment = @post.comments.build(params[:comment])
    @comment.user_id = session[:user_id] 

    respond_to do |format|
      if @comment.duplicate? or @comment.save
        format.html { redirect_to(@post) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
        format.js 
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
        format.js { render :nothing => true}
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = @post.comments.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to([@post, @comment]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(post_comments_url(@post)) }
      format.xml  { head :ok }
      format.js #destroy.rjs 
    end
  end

  private

  def load_post
    @post = Post.find(params[:post_id])
  end

end
