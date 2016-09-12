class User < ApplicationRecord
	attr_accessor :remember_token, :activation_token, :reset_token
	before_save :email_downcase
	before_create :create_activation_digest
	validates :name, presence: true, length: { in: 3..50 }
	# email 的唯一性验证并不能做到数据库中的唯一
	# 为此需要为数据库的 email 列添加索引，并为索引添加唯一性验证
	# rails g migration add_index_to_users_email
	# add_index :users, :email, unique: true
	validates :email, presence: true, length: { maximum: 255 }, email_format: { message: "is not looking good." }, 
										uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }, presence: true, allow_nil: true
	has_secure_password

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end
	def forget
		update_attribute(:remember_digest, nil)
	end
	def activate
		# update_attribute(:activated, true)
		# update_attribute(:activated_at, Time.zone.now)
		update_columns(activated: true, activated_at: Time.zone.now)
	end
	def send_activation_email
		UserMailer.account_activation(self).deliver_now
	end
	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end
	def create_reset_digest
		self.reset_token = User.new_token
		update_attribute(:reset_digest, User.digest(reset_token))
		update_attribute(:reset_sent_at, Time.zone.now)
	end
	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end
	def password_reset_expired?
		reset_sent_at < 2.hours.ago
	end

	# 为 users.yml 中的测试数据库中的用户生成密码
	def User.digest string
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
																									BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end
	def User.new_token
		SecureRandom.urlsafe_base64
	end
	private
		def email_downcase
			self.email.downcase!
		end
		def create_activation_digest
			self.activation_token = User.new_token
			self.activation_digest = User.digest(activation_token)
		end
end
