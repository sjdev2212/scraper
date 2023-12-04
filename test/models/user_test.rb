require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should create a new user" do
    assert_difference 'User.count', 1 do
      user = User.create(name: 'some', email: 'test@example.com', password: 'password',
                         password_confirmation: 'password')
      assert user.valid?
    end
  end
  test "should not create user with no name" do
    assert_no_difference 'User.count' do
      user = User.create(name: '', email: 'some@gmail.com', password: 'password', password_confirmation: 'password')
      assert_not user.valid?
    end
  end
  test "should not create user with no email" do
    assert_no_difference 'User.count' do
      user = User.create(name: 'some', email: '', password: 'password', password_confirmation: 'password')
      assert_not user.valid?
    end
  end

  test "should not create user with no password" do
    assert_no_difference 'User.count' do
      user = User.create(name: 'some', email: 'some@some.com', password: '', password_confirmation: 'password')
      assert_not user.valid?
    end
  end
  test "should not create user with no password confirmation" do
    assert_no_difference 'User.count' do
      user = User.create(name: 'some', email: 'some@some.com', password: '313131', password_confirmation: '')
      assert_not user.valid?
    end
  end
end
