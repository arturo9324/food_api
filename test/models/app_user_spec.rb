require 'rails_helper'

RSpec.describe AppUser, type: :model do
	it { should validate_presence_of(:email) }
	it { should validate_uniqueness_of(:email) }

	it "should create a new user if the uid and provider don't exist" do
		expect{
			AppUser.from_omniauth({uid: "12345", provider: "google", email: "123a@gmail.com", name: "ajdad"})
		}.to change(AppUser, :count).by(1)
	end


end
