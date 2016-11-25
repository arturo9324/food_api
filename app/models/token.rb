class Token < ApplicationRecord

belongs_to :app_user
	before_create :generate_token

	def is_valid?
		DateTime.now < self.expires_at
	end

	def generate_token
		begin
			self.token = SecureRandom.hex(30)
		end while Token.where( token: self.token ).any?
		self.expires_at ||=3.month.from_now
	end
	
end
