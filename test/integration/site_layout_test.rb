require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
	test "layout links" do
		get root_url
		assert_template 'pages/home'
		assert_select "title", full_title # 需要在 test_helper.rb 中引入 ApplicationHelper
		assert_select 'a[href=?]', root_url, count: 1
		assert_select 'a[href=?]', help_url
		assert_select 'a[href=?]', about_url
	end
end
