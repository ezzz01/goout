require File.dirname(__FILE__) + '/../test_helper'

class UserControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  def test_registration_success
    post :register, :user => { :username => "new_username", :email => "myemail@post.de", :password => "mynewpass"}
    user = assigns(:user)

    assert_not_nil session[:user_id]
    assert_equal user.id, session[:user_id]
  end
end
