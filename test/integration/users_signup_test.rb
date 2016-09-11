require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	def setup
		ActionMailer::Base.deliveries.clear
	end
	test "invalid signup information" do
		get signup_url
		assert_no_difference 'User.count' do
			post users_url, params: {
				user: {
					name: "",
					email: "",
					password: "",
					password_confirmation: ""
				}
			}
		end
		assert_template 'users/new'
	end

	test "valid signup information with account activation" do
		get signup_url
		assert_difference 'User.count', 1 do
			post signup_url, params: {
				user: {
					name: "foobar",
					email: "foo@bar.com",
					password: "foobar",
					password_confirmation: "foobar"
				}
			}
		end
		assert_equal 1, ActionMailer::Base.deliveries.size
		user = assigns(:user)
		assert_not user.activated?

		log_in_as(user)
		assert_not is_logged_in?

		get edit_account_activation_url("invalid token", email: user.email)
		assert_not is_logged_in?

		get edit_account_activation_url(user.activation_token, email: "wrong")
		assert_not is_logged_in?

		get edit_account_activation_url(user.activation_token, email: user.email)
		assert user.reload.activated?
		follow_redirect!
		assert is_logged_in?
		assert_template 'users/show'
		assert_not flash.empty?
	end

end
