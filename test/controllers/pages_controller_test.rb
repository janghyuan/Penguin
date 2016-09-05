require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
	def setup
		@title = "Shandong University of Technology"
	end
  test "should get about" do
    get pages_about_url
    assert_response :success
    assert_select "title", "About | #{@title}"
  end

  test "should get help" do
  	get pages_help_url
  	assert_response :success
    assert_select "title", "Help | #{@title}"
  end

  test "should get home" do
  	get pages_home_url
  	assert_response :success
  	assert_select "title", "#{@title}"
  end
end
