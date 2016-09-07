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
end
