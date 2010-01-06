require File.dirname(__FILE__) + '/../test_helper'

require 'users_controller' 
class UsersControllerTest < ActionController::TestCase
  include ApplicationHelper
  fixtures :users

  def setup
    @valid_user = users(:valid_user)
    @invalid_user = users(:invalid_user)
    @user = users(:one)
  end
  
  def index
    assert_equal @title, "User profile"
  end


  def test_index_unauthorized
    #get :index
    #assert_response :redirect
    #assert_redirected_to :action => "login"
  end

  def test_index_authorized
    #get :index
    #assert_response :success
    #assert_template "index"
  end

  def test_edit_page
    authorize @valid_user
    assert_response :success
    get :edit, :id => @valid_user
    assert_response :success
    assert_template "edit"
    #assert_form_tag "/users/edit"
    assert_email_field @valid_user.email
    assert_password_field "current_password"
    assert_password_field
    assert_password_field "password_confirmation"
    assert_submit_button "Update"
  end



  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_show_user
    get :show, :id => users(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => users(:one).id
    assert_response :success
  end

  def test_should_update_user
    put :update, :id => users(:one).id, :user => { }
    assert_not_nil assigns(:user)
    assert_equal "User was successfully updated.", flash[:notice]
    assert_redirected_to user_path(assigns(:user))
  end

  def test_should_destroy_user
    assert_difference('User.count', -1) do
      delete :destroy, :id => users(:one).id
    end

    assert_redirected_to users_path
  end




  private

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
