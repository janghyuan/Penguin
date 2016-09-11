require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:michael)
		@non_admin = users(:archer)
		@unactivated = users(:unactivated)
	end

	test "index including pagination and delete links" do
		log_in_as(@user)
		get users_url
		assert_template 'users/index'
		assert_select 'div.pagination'
		User.paginate(page: 1, per_page: 10).each do |user|
			assert_select 'a[href=?]', user_url(user)
			unless user.admin?
				assert_select 'a[href=?]', user_url(user), text: "DELETE"
			end
		end
		assert_difference 'User.count', -1 do
			delete user_url(@non_admin)
		end
	end

	test "index as non-admin" do
		log_in_as(@non_admin)
		get users_url
		assert_select 'a', text: "DELETE", count: 0
	end

	test "unactivated user page should be redirected to root url" do
		log_in_as(@user)
		get user_url(@unactivated)
		assert_redirected_to root_url
	end
end
