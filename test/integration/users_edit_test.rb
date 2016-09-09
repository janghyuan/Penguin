require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:michael)
	end
	test "unsuccessful edit" do
		get edit_user_url(@user)
		assert_template 'users/edit'
		patch user_url(@user), params: {
			user: {
				name: "michael",
				email: "",
				password: "foo",
				password_confirmation: "bar"
			}
		}
		assert_template 'users/edit'
	end

	test "successful edit" do
		get edit_user_url(@user)
		name = "foobar"
		email = "foo@bar.com"
		assert_template 'users/edit'
		patch user_url(@user), params: {
			user: {
				name: name,
				email: email,
				password: "",
				password_confirmation: ""
			}
		}
		assert_not flash.nil?
		follow_redirect!
		assert_template 'users/edit'
		assert_equal name, @user.reload.name
		assert_equal email, @user.reload.email
	end
end
