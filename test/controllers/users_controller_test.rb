require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:michael)
		@other_user = users(:archer)
	end
  test "should get new" do
    get signup_url
    assert_response :success
  end

  test "should redirect edit when not logged in" do
  	log_in_as(@other_user)
  	get edit_user_url(@user)
  	assert_not flash.empty?
  	assert_redirected_to root_url
  end
  test "should redirect update when not logged in" do
  	log_in_as(@other_user)
  	patch user_url(@user), params: { user: { name: "michael", email: "michael@gmail.com" } }
  	assert_not flash.empty?
  	assert_redirected_to root_url
  end
  test "should redirect index when not logged in" do
    get users_url
    assert_redirected_to login_url
  end
end
