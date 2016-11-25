class AppUser < ApplicationRecord

	validates :email, presence: true, email: true, uniqueness: true
	validates :name, presence: true
	validates :uid,presence:true
	validates :provider, presence: true

 def self.from_omniauth(data)
  AppUser.where(provider: data[:provider], uid: data[:uid]).first_or_create do |user|
  user.email = data[:email]
  user.name =data[:name]
  user.token = request.env["omniauth.auth"]['credentials']['token']
  user.token_secret = request.env["omniauth.auth"]['credentials']['secret']
 end
end
	
end
