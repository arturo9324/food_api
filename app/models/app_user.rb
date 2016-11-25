class AppUser < ApplicationRecord

<<<<<<< HEAD
	validates :email, presence: true, email: true, uniqueness: true
=======
	has_many :tokens

	validates :email, presence: true, email: true
>>>>>>> 34854c68899985a9e68582cee0d9201d3ac60f1f
	validates :name, presence: true
	validates :uid,presence:true
	validates :provider, presence: true

<<<<<<< HEAD
 def self.from_omniauth(data)
  AppUser.where(provider: data[:provider], uid: data[:uid]).first_or_create do |user|
  user.email = data[:email]
  user.name =data[:name]
  user.token = request.env["omniauth.auth"]['credentials']['token']
  user.token_secret = request.env["omniauth.auth"]['credentials']['secret']
 end
end
	
=======
	def self.from_omniauth(data)
		AppUser.where(provider: data[:provider], uid: data[:uid]).first_or_create do |user|
			user.email = data[:email]
			user.name =data[:name]
		end
	end

>>>>>>> 34854c68899985a9e68582cee0d9201d3ac60f1f
end
