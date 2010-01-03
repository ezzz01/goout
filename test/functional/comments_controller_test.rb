require 'test_helper'
require 'comments_controller' 

class CommentsControllerTest < ActionController::TestCase
  fixtures :comments, :posts, :users

  def setup
    @user = users(:valid_user) 
    @comment = comments(:one) 
    @post = posts(:one) 
    @valid_comment = { :user_id => @user, :post_id => @post, 
                       :body => "Comment Body"} 
  end

  test "should redirect to post" do
    get :index, :user_id => @user, :post_id => @post
    assert_redirected_to user_post_path(@post.user_id, @post)
  end

  test "should get new" do
    get :new, :user_id => @user, :post_id => @post
    assert_redirected_to user_post_path(@post.user_id, @post)
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, :post_id => @post, :user_id => @post.user_id, :comment => @valid_comment
    end

    assert_redirected_to user_post_path(@post.user_id, @post)
  end

  test "should show comment" do
    get :show, :id => comments(:one).to_param
    assert_response :success
  end

  test "should redirect from edit" do
    get :edit, :id => comments(:one).to_param, :post_id => comments(:one).post.to_param 
    assert_redirected_to user_post_path(@post.user_id, @post)
  end

  test "should update comment" do
    put :update, :id => comments(:one).to_param, :comment => { }
    assert_redirected_to comment_path(assigns(:comment))
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete :destroy, :id => comments(:one).to_param
    end

    assert_redirected_to comments_path
  end
end
