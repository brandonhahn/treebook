require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, id: users(:brandon).profile_name
    assert_response :success
    assert_template "profiles/show"
  end

  test "should render a 404 if profile not found" do
  	get :show, id: "Not a profile"
  	assert_response :not_found
  end

  test "variables are correctly assigned on profile request" do
  	get :show, id: users(:brandon).profile_name
  	assert assigns(:user)
  	assert_not_empty assigns(:statuses)
  end

  test "only show the correct user's statuses" do 
  	get :show, id: users(:brandon).profile_name
  	assigns(:statuses).each do |status|
  		assert_equal users(:brandon), status.user
  	end
  end

end
