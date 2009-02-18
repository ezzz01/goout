require File.dirname(__FILE__) + '/../test_helper'

require 'user_controller' 
class UserControllerTest < ActionController::TestCase
  include ApplicationHelper
  fixtures :users

  def setup
    @controller = UserController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    @valid_user = users(:valid_user)
    @invalid_user = users(:invalid_user)
  end
  
  def index
    assert_equal @title, "User profile"
  end

  def test_registration_page
    get :register
    assert_response :success
    assert_template "register"
    assert_tag "form", :attributes => { :action => "/user/register", 
                                          :method => "post" }
    assert_tag "input", :attributes => { :name => "user[username]", 
                                          :type => "text", 
                                          :size => User::USERNAME_SIZE, 
                                          :maxlength => User::USERNAME_MAX_LENGTH }
    assert_tag "input", :attributes => { :name => "user[email]", 
                                          :type => "text", 
                                          :size => User::EMAIL_SIZE, 
                                          :maxlength => User::EMAIL_MAX_LENGTH }
    assert_tag "input", :attributes => { :name => "user[password]", 
                                          :type => "password", 
                                          :size => User::PASSWORD_SIZE, 
                                          :maxlength => User::PASSWORD_MAX_LENGTH }
    assert_tag "input", :attributes => { :type => "submit" }
  end

  def test_registration_success
    post :register, :user => { :username => "new_username",
                                :email => "myemail@post.de",
                                :password => "mynewpass"}
    user = assigns(:user)
    assert_not_nil user
    new_user = User.find_by_username_and_email(user.username, user.email)
    assert_equal user, new_user
    assert_redirected_to :action => "index"
    assert_not_nil logged_in? 
    assert_equal user.id, session[:user_id]
  end

  def test_registration_failure
    post :register, :user => { :username => "aa/test",
                                :email => "net@@ei@sinas,lt",
                                :password => "123" }
    assert_response :success
    assert_template "register"
      #todo, kai veiks klaidu rodymas registracijos formoje
  end


  def test_login_page
    get :login
    assert_response :success
    assert_template "login"
    assert_tag "form", :attributes => { :action =>'/user/login', :method => 'post' }
    assert_tag "input", :attributes => {
                        :name => "user[username]",
                        :type => "text"}
    assert_tag "input", :attributes => {
                        :name => "user[password]",
                        :type => "password"}
    assert_tag "input", :attributes => {
                        :type => "submit",
                        :value => "Login" }
  end

  def test_login_success
    assert_equal @valid_user.password, "myu"
#    try_to_login @users["valid_user"]
    #assert logged_in?
    #assert_equal @valid_user, session[:user_id]
    #assert_response :redirect
    #assert_redirected_to "index"
  end
  
  def test_logout_success
    try_to_login @valid_user
    get :logout
    assert_response :redirect
    assert_redirected_to "index", :controller => "site"
    assert_equal "Logged out", flash[:notice]
    #assert_nil session[:user_id]
  end

  def test_index_unauthorized
    get :index
    assert_response :redirect
    assert_redirected_to :action => "login"
  end

  def test_index_authorized
    #get :index
    #assert_response :success
    #assert_template "index"
  end


  private
  def try_to_login(user)
    post :login, :user => { :username => user.username, :password => user.password }
  end

end
