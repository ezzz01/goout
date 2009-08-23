class CommentsController < ApplicationController
 before_filter :load_post

  def load_post
    @post = Post.find(params[:post_id])
  end
 
  # GET /comments
  # GET /comments.xml
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = @post.comments.build
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
      format.js {
        render :update do |page|
          page.hide "add_comment_link_for_post_#{@post.id}"
          page.replace_html "new_comment_form_for_post_#{@post.id}",
            :partial => "new_comment", 
            :locals => {:button_name => t(:send)}
          page.show "new_comment_form_for_post_#{@post.id}"
        end
      }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = @post.comments.find(params[:id])
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
        format.js {render :update do |page|
              page.replace_html "comments_for_post_#{@post.id}",
                :partial => "comment",
                :locals => {:button_name => t(:send)},
                :collection => @post.comments 
              page.replace_html "comments_number_for_post_#{@post.id}", @post.comments.size
              page.show "add_comment_link_for_post_#{@post.id}"
              page.hide "new_comment_form_for_post_#{@post.id}"
          end
        }
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
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(post_comments_url(@post)) }
      format.xml  { head :ok }
    end
  end
end
