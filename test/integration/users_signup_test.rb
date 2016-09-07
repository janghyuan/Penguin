require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
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

	test "valid signup information" do
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
		follow_redirect!
		assert_template 'users/show'
		assert_not flash.empty?
	end

end
