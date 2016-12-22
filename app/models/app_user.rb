class AppUser < ApplicationRecord

	has_many :tokens
	has_one :info_app_user
	has_many :best_nutrient_values

	validates :email, presence: true, email: true, uniqueness: true
	validates :name, presence: true
	validates :uid,presence:true
	validates :provider, presence: true

	def self.from_omniauth(data)
		AppUser.where(provider: data[:provider], uid: data[:uid]).first_or_create do |user|
			user.email = data[:email]
			user.name =data[:name]
		end
	end
end
