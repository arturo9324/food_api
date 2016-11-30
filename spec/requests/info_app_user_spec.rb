require 'rails_helper'

RSpec.describe Api::V1::InfoAppUsersController, type: :request do
	describe "POST /api/v1/info_app_users" do
		before :each do
			@token = FactoryGirl.create(:token)
			@user = @token.app_user
		end
		context "with valid params" do
			before :each do
				@info = {fecha_nacimiento: 11.years.from_now, peso: 40, estatura: 35, sexo: 0, max_calorias: 50, min_calorias:30, embarazo: 0, lactancia: 1 }
				post "/api/v1/info_app_users", params: {info: @info, uid: @user.uid, provider: @user.provider, token: @token.token }
			end

			it { have_http_status(200) }

			it { change( InfoAppUser, :count ).by(1) }

			it { expect(response.header['Content-Type']).to include 'application/json' }

			it "should respond with the created user" do
				json = JSON.parse(response.body)
				expect(json['errors']).to eq(11.years.from_now)
			end
		end
	end
end