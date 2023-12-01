require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should not save user without email' do
    user = User.new(password: 'password')
    assert_not user.save
  end
  test 'should not save user without password' do
    user = User.new(email: 'some@gmail.com')
    assert_not user.save
  end
  test 'should not save user with invalid email' do
    user = User.new(email: 'so22', password: 'password')
    assert_not user.save
  end
  test 'should not save user with password less than 6 characters' do
    user = User.new(email: 'some@example.com', password: 'pa')
    assert_not user.save
  end
end
