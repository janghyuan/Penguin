class User < ApplicationRecord
	before_save :email_downcase
	validates :name, presence: true, length: { in: 3..50 }
	# email 的唯一性验证并不能做到数据库中的唯一
	# 为此需要为数据库的 email 列添加索引，并为索引添加唯一性验证
	# rails g migration add_index_to_users_email
	# add_index :users, :email, unique: true
	validates :email, presence: true, length: { maximum: 255 }, email_format: { message: "is not looking good." }, 
										uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }, presence: true
	has_secure_password

	# 为 users.yml 中的测试数据库中的用户生成密码
	def User.digest string
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
																									BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end
	private
		def email_downcase
			self.email.downcase!
		end
end
