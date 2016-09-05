require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
	test "full_title helper" do
		assert_equal full_title, "Shandong University of Technology"
		assert_equal full_title("Home"), "Home | Shandong University of Technology"
	end
end