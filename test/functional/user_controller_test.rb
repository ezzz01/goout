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
    assert_form_tag "/user/register"
    assert_username_field
    assert_email_field
    assert_password_field
    assert_submit_button "Register"
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
    assert_tag "input", :attributes => { :name => "user[remember_me]", :type => "checkbox" }
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

  def test_edit_page
    #authorize @valid_user
    assert_response :success
    assert_template "edit"
    assert_form_tag "/user/edit"
    assert_email_field @valid_user.email
    assert_password_field "current_password"
    assert_password_field
    assert_password_field "password_confirmation"
    assert_submit_button "Update"
  end


  private
  def authorize(user)
    @request.session[:user_id] = user.id
  end

  def try_to_login(user)
    post :login, :user => { :username => user.username, :password => user.password }
  end

  def assert_email_field(email = nil, options = {})
    assert_input_field("user[email]", email, "text",
                       User::EMAIL_SIZE, User::EMAIL_MAX_LENGTH, options)
  end

  def assert_password_field(password_field_name = "password", options = {})
    blank = nil
    assert_input_field("user[#{password_field_name}]", blank, "password",
                       User::PASSWORD_SIZE, User::PASSWORD_MAX_LENGTH, options)
  end

  def assert_username_field(username = nil, options = {})
    assert_input_field("user[username]", username, "text",
                       User::USERNAME_SIZE, User::USERNAME_MAX_LENGTH, options)
  end

end
