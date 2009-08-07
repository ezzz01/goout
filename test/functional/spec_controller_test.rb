require File.dirname(__FILE__) + '/../test_helper'
require 'spec_controller'

class SpecControllerTest < ActionController::TestCase
  fixtures :users
  fixtures :specs

  def setup
    @controller = SpecController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    @user = users(:valid_user)
    @spec = specs(:valid_spec)
  end

  def test_edit_success
    authorize @user
    post :edit,
        :spec => { :first_name => "new first name",
                  :last_name => "new last name"}
    spec = assigns(:spec)
    new_user = User.find(spec.user.id)
    assert_equal new_user.spec, spec
    assert_response :redirect
    assert_redirected_to :controller => "user", :action => "index"
  end

end
