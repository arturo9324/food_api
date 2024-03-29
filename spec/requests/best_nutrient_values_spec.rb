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
				#pp json
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
			@attributes = Hash.new()
			@value =[]
			@miss_attributes = Hash.new()
			@attr = ""
			@measure = FactoryGirl.create(:measure)
		end
		#best = {"_1" => {"value" => 5}, "_2" => {"value" => 5}, "_3" => {"value" => 5}}
		#=> {"_1"=>{"value"=>5}, "_2"=>{"value"=>5}, "_3"=>{"value"=>5}}
		
		context "new record with correct values" do
			before :each do
				for i in 1..3
					@nutrients = FactoryGirl.create(:nutrient, measure: @measure)
					value = Hash.new()
					value["value"] = 5
					@attributes["_#{@nutrients.id}"] = value
				end
				#pp @attributes
				post api_v1_values_path, params: {best: @attributes, uid: @user.uid, provider: @user.provider, token: @token.token}
			end

			it { expect(response).to have_http_status(:ok) }

			it { expect(BestNutrientValue.where(app_user: @user).count).to eq(3) }

			it "should respond with the created BNV" do
				json = JSON.parse(response.body)
				#pp @attributes.inspect
				#pp json
				expect(json['data']['relations']['best_nutrient_values']).to_not be_empty
			end
		end

		context "new record with incorrect values" do
			before :each do
				for i in 1..3
					@nutrients = FactoryGirl.create(:nutrient, measure: @measure)
					value = Hash.new()
					value["value"] = "asadasd"
					@attributes["_#{@nutrients.id}"] = value
				end
				post api_v1_values_path, params: {best: @attributes, uid: @user.uid, provider: @user.provider, token: @token.token}
			end

			it { expect(response).to have_http_status(:unprocessable_entity) }

			it { expect(BestNutrientValue.where(app_user: @user).count).to eq(0) }

			it "should respond with the error explanation" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end
		end

		context "whit no sended data" do
			before :each do
				for i in 1..3
					@nutrients = FactoryGirl.create(:nutrient, measure: @measure)
				end
				post api_v1_values_path, params: {uid: @user.uid, provider: @user.provider, token: @token.token}
			end

			it { expect(response).to have_http_status(:unprocessable_entity) }

			it { expect(BestNutrientValue.where(app_user: @user).count).to eq(0) }

			it "should respond with the error explanation" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end
		end

		context "whith missed nutrients" do
			before :each do
				for i in 1..3
					@nutrients = FactoryGirl.create(:nutrient, measure: @measure)
					if i%2 ==0
						value = Hash.new()
						value["value"] = 5
						@miss_attributes["_#{@nutrients.id}"] = value
					end
				end
				post api_v1_values_path, params: {best: @miss_attributes, uid: @user.uid, provider: @user.provider, token: @token.token}
			end

			it { expect(response).to have_http_status(:unprocessable_entity) }

			it { expect(BestNutrientValue.where(app_user: @user).count).to eq(0) }

			it "should respond with the error explanation" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end
		end

		context "whit data saved and correct values" do
			before :each do
				for i in 1..3
					@nutrients = FactoryGirl.create(:nutrient, measure: @measure)
					FactoryGirl.create(:best_nutrient_value, app_user: @user, nutrient: @nutrients)
					value = Hash.new()
					value["value"] = 5
					@attributes["_#{@nutrients.id}"] = value
				end
				@first_id = BestNutrientValue.first.id
				post api_v1_values_path, params: {best: @attributes, uid: @user.uid, provider: @user.provider, token: @token.token}
			end

			it { expect(response).to have_http_status(:ok) }

			it { expect(BestNutrientValue.where(app_user: @user).count).to eq(3) }

			it "should respond with the created BNV" do
				json = JSON.parse(response.body)
				expect(json['data']['relations']['best_nutrient_values']).to_not be_empty
			end

			it "should respond whit diferent id for the BNV" do
				last_id = BestNutrientValue.first.id
				expect(last_id).to_not eq(@first_id)
			end
		end	

		context "whit data saved and incorrect values" do
			before :each do
				for i in 1..3
					@nutrients = FactoryGirl.create(:nutrient, measure: @measure)
					FactoryGirl.create(:best_nutrient_value, app_user: @user, nutrient: @nutrients)
					value = Hash.new()
					value["value"] = "asdasd"
					@attributes["_#{@nutrients.id}"] = value
				end
				@first_id = BestNutrientValue.first.id
				post api_v1_values_path, params: {best: @attributes, uid: @user.uid, provider: @user.provider, token: @token.token}
			end

			it { expect(response).to have_http_status(:unprocessable_entity) }

			it { expect(BestNutrientValue.where(app_user: @user).count).to eq(3) }

			it "should respond with the errror explanation" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end

			it "should respond whit the same id for the BNV" do
				last_id = BestNutrientValue.first.id
				expect(last_id).to eq(@first_id)
			end
		end
	end
end 