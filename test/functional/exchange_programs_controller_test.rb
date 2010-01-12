require 'test_helper'

class ExchangeProgramsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:exchange_programs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create exchange_program" do
    assert_difference('ExchangeProgram.count') do
      post :create, :exchange_program => { }
    end

    assert_redirected_to exchange_program_path(assigns(:exchange_program))
  end

  test "should show exchange_program" do
    get :show, :id => exchange_programs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => exchange_programs(:one).to_param
    assert_response :success
  end

  test "should update exchange_program" do
    put :update, :id => exchange_programs(:one).to_param, :exchange_program => { }
    assert_redirected_to exchange_program_path(assigns(:exchange_program))
  end

  test "should destroy exchange_program" do
    assert_difference('ExchangeProgram.count', -1) do
      delete :destroy, :id => exchange_programs(:one).to_param
    end

    assert_redirected_to exchange_programs_path
  end
end
