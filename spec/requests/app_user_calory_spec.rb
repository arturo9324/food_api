require 'rails_helper'

RSpec.describe Api::V1::AppUserCaloriesController, type: :request do
	before :each do
		@user = FactoryGirl.create(:app_user)
		@token = FactoryGirl.create(:token, app_user: @user)
	end

	describe "POST /api/v1/app_user_calories" do

		context "with valid record" do
			before :each do
				@calories = { gasto: "6.0"}
				post api_v1_calories_path, params: { uid: @user.uid, provider: @user.provider, token: @token.token, calories: @calories }
			end

			it { expect(response).to have_http_status(:ok) }

			it "should respond with the created record" do
				json = JSON.parse(response.body)
				expect(json['data']['attributes']).to_not be_empty
			end
		end

		context "with invalid record" do
			before :each do
				@calories = { gasto: "ghffddsghftydty"}
				post api_v1_calories_path, params: { uid: @user.uid, provider: @user.provider, token: @token.token, calories: @calories }
			end

			it { expect(response).to have_http_status(:unprocessable_entity) }

			it "should respond with the created record" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end
		end

		context "with no record info sended" do
			before :each do
				post api_v1_calories_path, params: { uid: @user.uid, provider: @user.provider, token: @token.token }
			end

			it { expect(response).to have_http_status(:unprocessable_entity) }

			it "should respond with the created record" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end
		end
	end

	describe "GET /api/v1/app_user_calories" do

		context "with records created and no date" do
			before :each do
				FactoryGirl.create(:app_user_calory, app_user: @user)
				FactoryGirl.create(:app_user_calory, app_user: @user, gasto: 20)
				FactoryGirl.create(:app_user_calory, app_user: @user, gasto: 15)
				get api_v1_calories_path, params: { uid: @user.uid, provider: @user.provider, token: @token.token }
			end

			it { expect(response).to have_http_status(:ok) }

			it "should respnd with the sum of calories" do 
				json = JSON.parse(response.body)
				#pp json
				expect(json['data']).to_not be_empty
			end
		end

		context "with records created and valid date" do
			before :each do
				@calory1 = FactoryGirl.create(:app_user_calory, app_user: @user)
				@calory2 = FactoryGirl.create(:app_user_calory, app_user: @user, gasto: 20)
				@calory3 = FactoryGirl.create(:app_user_calory, app_user: @user, gasto: 15)
				@calory1.created_at = "2016-12-28 00:00:00"
				@calory2.created_at = "2016-12-28 00:00:00"
				@calory3.created_at = "2016-12-28 00:00:00"
				@calory1.save
				@calory2.save
				@calory3.save
				get api_v1_calories_path, params: { uid: @user.uid, provider: @user.provider, token: @token.token, fecha: "2016-12-28" }
			end

			it { expect(response).to have_http_status(:ok) }

			it "should respnd with the sum of calories" do 
				json = JSON.parse(response.body)
				#pp json
				expect(json['data']).to_not be_empty
			end
		end

		context "with  no records created and valid date" do
			before :each do
				get api_v1_calories_path, params: { uid: @user.uid, provider: @user.provider, token: @token.token, fecha: "2016-12-28" }
			end

			it { expect(response).to have_http_status(:not_found) }

			it "should respnd with the sum of calories" do 
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end
		end

		context "with no records created and no date" do
			before :each do
				get api_v1_calories_path, params: { uid: @user.uid, provider: @user.provider, token: @token.token }
			end

			it { expect(response).to have_http_status(:not_found) }

			it "should respnd with the sum of calories" do 
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end
		end 

		context "with invalid date" do
			before :each do
				get api_v1_calories_path, params: { uid: @user.uid, provider: @user.provider, token: @token.token, fecha: "2016-13-40" }
			end

			it { expect(response).to have_http_status(:not_found) }

			it "should respnd with the sum of calories" do 
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end
		end

		context "with invalid date format" do
			before :each do
				get api_v1_calories_path, params: { uid: @user.uid, provider: @user.provider, token: @token.token, fecha: "asdsfsdfsdfsg" }
			end

			it { expect(response).to have_http_status(:not_found) }

			it "should respnd with the sum of calories" do 
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end
		end
	end
end