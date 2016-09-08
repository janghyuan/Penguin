ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include ApplicationHelper

  # 在定义 current_user 时，会用到 cookies.signed 方法，而在测试环境中无法使用这个方法
  # 所以在这里重新定义一个函数
  def is_logged_in?
  	!session[:user_id].nil?
  end

  # 控制器测试中用到
  def log_in_as(user)
  	session[:user_id] = user.id
  end
end

class ActionDispatch::IntegrationTest
	def log_in_as(user, password: "foobar", remember_me: "1")
		post login_url, params: {
			session: {
				email: user.email,
				password: password,
				remember_me: remember_me
			}
		}
	end
end
