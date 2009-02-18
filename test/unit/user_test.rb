require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
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
  end

end
