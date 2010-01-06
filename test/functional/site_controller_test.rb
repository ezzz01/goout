require File.dirname(__FILE__) + '/../test_helper'

class SiteControllerTest < ActionController::TestCase
include ApplicationHelper

  def setup
    @valid_user = users(:valid_user)
    @invalid_user = users(:invalid_user)
  end
  
  # Replace this with your real tests.
  def test_index
    get :index
    assert_response :success
    assert_template "index"
  end

  def test_about
    get :about
    assert_response :success
    assert_template "about"
  end

  def test_help
    get :help
    assert_response :success 
    assert_template "help"
  end

 def test_registration_page
    get :register
    assert_response :success
    assert_template "register"
    assert_form_tag "/site/register"
    assert_username_field
    assert_email_field
    assert_password_field
    assert_submit_button "Registruotis"
  end

  def test_should_register_user
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
    assert_tag "form", :attributes => { :action =>'/site/login', :method => 'post' }
    assert_tag "input", :attributes => {
                        :name => "user[username]",
                        :type => "text"}
    assert_tag "input", :attributes => {
                        :name => "user[password]",
                        :type => "password"}
    assert_tag "input", :attributes => {
                        :type => "submit",
                        :value => "Prisijungti" }
    assert_tag "input", :attributes => { :name => "user[remember_me]", :type => "checkbox" }
  end

  def test_login_success
    assert_equal @valid_user.password, "mylongpassword"

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
    assert_redirected_to :controller => "Site"
    assert_equal "Atsijungėte sėkmingai", flash[:notice]
    assert_nil session[:user_id]
  end

  
  private
  
  # Try to log a user in using the login action.
  # Pass :remember_me => "0" or :remember_me => "1" in options
  # to invoke the remember me machinery.
  def try_to_login(user, options = {})
    user_hash = { :username => user.username,
                  :password    => user.password }
    user_hash.merge!(options)
    post :login, :user => user_hash 
  end
  
   
  # Assert that the screen name field has the correct HTML.
  def assert_username_field(username = nil, options = {})
    assert_input_field("user[username]", username, "text",
                       User::USERNAME_SIZE, User::USERNAME_MAX_LENGTH,
                       options)
  end
  
  # Assert that the email field has the correct HTML.
  def assert_email_field(email = nil, options = {})
    assert_input_field("user[email]", email, "text",
                       User::EMAIL_SIZE, User::EMAIL_MAX_LENGTH,
                       options)
  end
  
 # Assert that the password field has the correct HTML.
  def assert_password_field(password_field_name = "password", options = {})
    # We never want a password to appear pre-filled into a form.
    blank = nil
    assert_input_field("user[#{password_field_name}]", blank, "password",
                       User::PASSWORD_SIZE, User::PASSWORD_MAX_LENGTH,
                       options)
  end
    




end
