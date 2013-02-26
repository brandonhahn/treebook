require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  test "that a status requires content" do
  	status = Status.new
  	assert !status.save
  	assert !status.errors[:content].empty?
  end

  test "that a status's content is at least 2 characters long" do
  	status = Status.new
  	status.content = "O"
  	assert !status.save
  	assert !status.errors[:content].empty?
  end

  test "that a status has a user associated with it" do
  	status = Status.new
  	status.content = "Hello world"
  	assert !status.save
  	assert !status.errors[:user_id].empty?
  end
end
