require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  fixtures :posts

  def setup
    @controller = PostsController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    @user = users(:valid_user)
    authorize @user
    @post = posts(:one)
  end
  
  test "should get index" do
    get :index, :user_id => @post.user_id
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    get :new, :user_id => @post.user_id
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post :create, :post => {:title => "my title", :body => "my body" }, :user_id => @post.user.id 
    end

    assert_redirected_to user_posts_url(:id => @post.user_id)
  end

  test "should show post" do
    get :show, :id => posts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => posts(:one).to_param
    assert_response :success
  end

  test "should update post" do
    put :update, :id => posts(:one).to_param, :post => { :title => "my other title", :body => "my other body" }
    assert assigns(:post)
    assert_redirected_to user_post_url(@post.user_id, @post)
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, :id => @post 
    end

    assert_redirected_to user_posts_url(:user_id => 1)
  end
end
