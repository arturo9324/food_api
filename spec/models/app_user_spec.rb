require 'rails_helper'

RSpec.describe AppUser, type: :model do

	it { should validate_presence_of(:email) }
	it { should validate_presence_of(:provider) }
	it { should validate_presence_of(:uid) }
	it { should validate_presence_of(:name) }

	it "should create a new user if the uid and provider don't exist" do
		expect{
			AppUser.from_omniauth({uid: "12345", provider: "google", email: "123a@gmail.com", name: "ajdad"})
		}.to change(AppUser, :count).by(1)
	end

	it "should not create a new user if the info is missing" do
		expect{
			AppUser.from_omniauth({})
		}.to change(AppUser, :count).by(0)
	end
end
