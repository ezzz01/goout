class SiteController < ApplicationController

  def index
      @title = t(:start_page) 
      @content = Concept.find_by_title("goout_start").revisions.last
      @question = Question.new
  end

  def about
      @title = t(:about)
      @content = Concept.find_by_title("goout_about").revisions.last
  end

  def help
      @title = t(:help) 
      @content = Concept.find_by_title("goout_help").revisions.last
  end

  def blog
      @title = t(:project_blog) 
      @user = User.find_by_username('admin')

      @title = t(:blog_posts, :username => @user.username )
      @blog_url = @user.blog_url 

      if (params[:tag_id])
          @posts = @user.posts.find_tagged_with(params[:tag_id], :order => "created_at DESC", :conditions => "deleted = 0" )
          @posts = @posts.paginate(:per_page => 20)
      else
          @posts = Post.find_all_by_user_id(@user.id, :order => "created_at DESC", :conditions => "deleted = 0") 
          @posts = @posts.paginate(:per_page => 20)
      end

      @tags = @user.posts.tag_counts

      render 'posts/index'
  end

  def register
    @title = t(:register)
    @register_button = t(:register_button) 
    if param_posted?(:user) 
      @user = User.new(params[:user])
      if @user.save
        @user.login!(session) 
        flash[:notice] = t(:registration_successful) 
        redirect_to_forwarding_url
      else 
        @user.clear_password!
      end
    end
  end

  def login
    @title = t(:login)
    @register = t(:register)
    @login_button = t(:login_button)
    if request.get?
      @user = User.new(:remember_me => cookies[:remember_me] || "0")
    elsif param_posted?(:user)
      @user = User.new(params[:user])
      user = User.find_by_username_and_password(@user.username, @user.password)
      if user
        user.login!(session) 
        @user.remember_me? ? user.remember!(cookies) : user.forget!(cookies) 
        flash[:notice] = t(:user) + " #{user.username} " + t(:logged_in)
        redirect_to_forwarding_url
      else
        @user.clear_password!
        flash[:notice] = t(:invalid_username_password)
      end
    end
  end

  def logout
    User.logout!(session, cookies)
    flash[:notice] = t(:logged_out)
    redirect_to :action => "index", :controller => "Site"
  end

  def edit
    @title = t(:edit_basic_info)
    @user = User.find(session[:user_id])
    if param_posted?(:user)
      attribute = params[:attribute]
      case attribute
      when "email"
        try_to_update @user, attribute
      when "blog_url"
        try_to_update @user, attribute
      when "password"
        if @user.correct_password?(params)
          try_to_update @user, attribute
        else
          @user.password_errors(params)
        end
      end
    end
    @user.clear_password!
  end


  private 

  def param_posted? (symbol)
    request.post? and params[symbol]
  end

  def redirect_to_forwarding_url
    if (redirect_url = session[:protected_page])
      session[:protected_page] = nil
      redirect_to redirect_url
    else
      redirect_to :action => "index"
    end
  end

  def try_to_update(user, attribute)
    if user.update_attributes(params[:user])
      flash[:notice] = "#{attribute} "+t(:attribute_updated)
      redirect_to :action => "index"
    end
  end



end
