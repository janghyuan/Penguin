require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:michael)
	end
	test "login with invalid information" do
		get login_url
		assert_template 'sessions/new'
		post login_url, params: {
			session: {
				email: "",
				password: ""
			}
		}
		assert_template 'sessions/new'
		assert_not flash.empty?
		get root_url
		assert flash.empty?
	end

	test "login with valid information followed by logout" do
		get login_url
		post login_url, params: {
			session: {
				email: @user.email,
				password: "foobar"
			}
		}
		assert is_logged_in?
		assert_redirected_to @user
		follow_redirect!
		assert_template 'users/show'
		assert_select "a[href=?]", login_url, count: 0
		assert_select "a[href=?]", logout_url

		delete logout_url
		assert_not is_logged_in?
		follow_redirect!
		assert_select "a[href=?]", login_url
		assert_select "a[href=?]", logout_url, count: 0
	end
end
