require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@test.com")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ''
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = ''
    assert_not @user.valid?
  end

  test "name should not be too long" do 
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = 'a' * 244 + '@example.com'
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM a_US_ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid"
    end
  end

  test "email validation should not accept invalid addresses" do
    valid_addresses = %w[user@example,com user@foo*com]
    valid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address.inspect} should be valid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present (not blank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password shoudl have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
