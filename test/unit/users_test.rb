require File.dirname(__FILE__) + '/../test_helper'

class UsersTest < ActiveSupport::TestCase
  fixtures :users
  def setup
    @valid_user = users(:valid_user)
    @invalid_user = users(:invalid_user)
  end

  def test_user_validity 
    assert @valid_user.valid? 
  end

  def test_user_invalidity
    assert !@invalid_user.valid?
    #attributes = [:username, :email, :password]
    #attributes.each do |attribute|
    #  assert @invalid_user.errors.invalid?(attribute)
    #end
  end
  
  def test_count
    assert_equal 4, User.count
  end

end
