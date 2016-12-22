require 'rails_helper'

RSpec.describe Api::V1::BestNutrientValuesController, type: :request do

	before :each do
		@user = FactoryGirl.create(:app_user)
		@token = FactoryGirl.create(:token, app_user: @user)
	end

	describe "GET /api/v1/best_nutrient_value" do
		
		context "with nutrients created" do
			before :each do
				for i in 1..3
					FactoryGirl.create(:best_nutrient_value, app_user: @user)
				end
				get api_v1_values_path, params: {uid: @user.uid, provider: @user.provider, token: @token.token}
			end

			it { expect(response).to have_http_status(:ok) }

			it "should return the asked records" do
				json = JSON.parse(response.body)
				expect(json['data']['attributes']).to_not be_empty
			end
		end

		context "whith nutrients not created" do
			before :each do
				get api_v1_values_path, params: {uid: @user.uid, provider: @user.provider, token: @token.token}
			end

			it { expect(response).to have_http_status(:not_found) }

			it "should respond with the error" do
				json = JSON.parse(response.body)
				expect(json["errors"]).to_not be_empty
			end
		end
	end


	describe "POST /api/v1/best_nutrient_value" do

		before :each do
			@attributes = []
			@miss_attributes = []
			@measure = FactoryGirl.create(:measure)
		end
		
		context "new record with correct values" do
			before :each do
				for i in 1..3
					@nutrients = FactoryGirl.create(:measure)
					@attributes << {:"_#{@nutrients.id}" => {maximo: 5, minimo: 5, optimo: 5}}
					#if i%2 ==0
						#@miss_attributes << {:"_#{@nutrients.id}" => {maximo: 5, minimo: 5, optimo: 5}}
					#end
				end
				post api_v1_values_path, params: {best: @attributes, uid: @user.uid, provider: @user.provider, token: @token.token}
			end

			it { expect(response).to have_http_status(:ok) }

			it { expect(BestNutrientValue.where(app_user: @user).count).to eq(3) }

			it "should respond with the created diseases" do
				json = JSON.parse(response.body)
				pp json.to_yaml
				expect(json['data']['relations']['best_nutrient_values']).to_not be_empty
			end
		end

		context "new record with incorrect values" do

		end

		context "whit no sended data" do

		end

		context "whit data saved and correct values" do

		end	

		context "whit data saved and incorrect values" do

		end
	end
end 