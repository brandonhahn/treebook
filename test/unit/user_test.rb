require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many (:user_friendships)
  should have_many (:friends)

  test "a user should enter a first name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:first_name].empty?
  end

  test "a user should enter a last name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:last_name].empty?
  end

  test "a user should enter a profile name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  end

  test "a user should enter a unique profile name" do
  	user = User.new
  	user.profile_name = users(:brandon).profile_name
  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  end

  test "a user should have a profile_name without spaces" do
  	user = User.new(first_name: "Brandon", last_name: "Hahn", email: "brandon2@brandonhahn.com")
    user.password = user.password_confirmation = "12345678"
  	user.profile_name = "My profile name with spaces"
  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  	assert  user.errors[:profile_name].include?("Must be formatted correctly.")
  end

  test "a user can have a correctly formatted profile name" do
    user = User.new(first_name: "Brandon", last_name: "Hahn", email: "brandon2@brandonhahn.com")
    user.password = user.password_confirmation = "12345678"
    user.profile_name = "brandonhahn_1"
    assert user.valid?
  end

  test "that no error is raised when trying to access a friend list" do
    assert_nothing_raised do
      users(:brandon).friends
    end
  end

  test "that creating friendships on a user works" do
    users(:brandon).friends << users(:mike)
    users(:brandon).friends.reload
    assert users(:brandon).friends.include?(users(:mike))
  end

end
