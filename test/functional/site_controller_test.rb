require File.dirname(__FILE__) + '/../test_helper'

class SiteControllerTest < ActionController::TestCase
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
    assert_response :help
    assert_template "help"
  end

end
