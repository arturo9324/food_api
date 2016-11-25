class Token < ApplicationRecord
<<<<<<< HEAD

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
	
=======
  belongs_to :app_user
  before_create :generate_token

  def is_valid?
  	DateTime.now < self.expires_at
  end

  private
  def generate_token 
  	begin 
  		self.token = SecureRandom.hex(30)
  	end while Token.where(token: self.token).any?
  	self.expires_at ||=3.month.from_now
  end
>>>>>>> 34854c68899985a9e68582cee0d9201d3ac60f1f
end
