class UsersController < ApplicationController
  #include ApplicationHelper
  #helper :profile
  #before_filter :protect, :only => ["index", "edit"]

  # GET /users
  # GET /users.xml
  def index
    @users = User.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
   #   format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @title = t(:user_profile)
    if (params[:user])
      @user = User.find_by_username(params[:user])
    else
      @user = User.find(params[:id])
    end

    @user.spec ||= Spec.new
    @spec = @user.spec
    @posts = @user.posts
    @activities = @user.activities

    respond_to do |format|
      format.html # show.html.erb
    #  format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
    #  format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @title = "Edit profile"
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(@user) }
     #   format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
     #   format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    @avatar = Avatar.new(:uploaded_data => params[:avatar_file])
    @service = UserService.new(@user, @avatar)

    respond_to do |format|
      if @service.update_attributes(params[:user], params[:avatar_file])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
     #   format.xml  { head :ok }
      else
        @avatar = @service.avatar
        format.html { render :action => "edit" }
      #  format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
    #  format.xml  { head :ok }
    end
  end

end
