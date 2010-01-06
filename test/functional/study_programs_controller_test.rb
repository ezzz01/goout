require 'test_helper'

class StudyProgramsControllerTest < ActionController::TestCase
  fixtures :study_programs, :subject_areas

  def setup
    @subject_area = subject_areas(:one) 
  end

  test "should get index (all)" do
    get :index
    assert_response :success
    assert_not_nil assigns(:study_programs)
  end

  test "should get index " do
    get :index, :subject_area_id => @subject_area
    assert_response :success
    assert assigns(:study_programs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create study_program" do
    assert_difference('StudyProgram.count') do
      post :create, :study_program => { :title => "new program", :subject_area_id => @subject_area }
    end

    assert_redirected_to study_program_path(assigns(:study_program))
  end

  test "should show study_program" do
    get :show, :id => study_programs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => study_programs(:one).to_param
    assert_response :success
  end

  test "should update study_program" do
    put :update, :id => study_programs(:one).to_param, :study_program => { }
    assert_redirected_to study_program_path(assigns(:study_program))
  end

  test "should destroy study_program" do
    assert_difference('StudyProgram.count', -1) do
      delete :destroy, :id => study_programs(:one).to_param
    end

    assert_redirected_to study_programs_path
  end
end
