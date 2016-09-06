class User < ApplicationRecord
	validates :name, presence: true, length: { in: 3..50 }
	validates :email, presence: true, length: { maximum: 255 }, email_format: { message: "is not looking good." }
end
