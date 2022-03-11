class User < ApplicationRecord
	validates :username,
	          presence: true,
	          uniqueness: {
			case_sensitive: false
	          },
	          length: {
			minimum: 3,
			maximum: 25
	          }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email,
	          presence: true,
	          uniqueness: true,
	          length: {
			minimun: 10,
			maximum: 155
	          },
	          format: {
			with: VALID_EMAIL_REGEX
	          }

	has_many :articles
end
