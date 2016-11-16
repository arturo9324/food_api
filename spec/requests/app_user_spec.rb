require 'rails_helper'

RSpec.describe Api::V1::AppUsersController, type: :request do

	describe "POST /api/v1/app_users" do

		before :each do
			@auth =  {uid: "12345", provider: "google", email: "123a@gmail.com", name: "ajdad"}
			post api_v1_app_users_path, params: { auth: @auth }
		end

		it { have_http_status(200) }

		it { change( AppUser, :count ).by(1) }
	end
end