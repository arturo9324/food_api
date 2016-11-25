require 'rails_helper'

RSpec.describe AppUser, type: :model do
<<<<<<< HEAD
	it { should validate_presence_of(:email) }
	it { should validate_uniqueness_of(:email) }
=======

	it { should validate_presence_of(:email) }
>>>>>>> 34854c68899985a9e68582cee0d9201d3ac60f1f

	it "should create a new user if the uid and provider don't exist" do
		expect{
			AppUser.from_omniauth({uid: "12345", provider: "google", email: "123a@gmail.com", name: "ajdad"})
		}.to change(AppUser, :count).by(1)
	end

<<<<<<< HEAD

end
=======
end
>>>>>>> 34854c68899985a9e68582cee0d9201d3ac60f1f
