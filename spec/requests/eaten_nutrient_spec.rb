require 'rails_helper'

RSpec.describe Api::V1::EatenNutrientsController, type: :request do

	before :each do
		@app_user = FactoryGirl.create(:app_user)
		@token = FactoryGirl.create(:token, app_user: @app_user)
		@measure = FactoryGirl.create(:measure)
		@user = FactoryGirl.create(:user)
	end

	describe "GET /api/v1/eaten_nutrients" do

		context "with valid date and created nutrients" do
			before :each do
				@nutrient1 = FactoryGirl.create(:nutrient, measure: @measure)
				@nutrient2 = FactoryGirl.create(:nutrient, measure: @measure)
				@nutrient3 = FactoryGirl.create(:nutrient, measure: @measure)
				@nutrient4 = FactoryGirl.create(:nutrient, measure: @measure)
				@product1 = FactoryGirl.create(:product, measure: @measure, user: @user)
				@product2 = FactoryGirl.create(:product, nombre: "segundo", codigo: "5555555555", measure: @measure, user: @user)
				@has_product1 = FactoryGirl.create(:has_product, product: @product1, app_user: @app_user, measure: @measure)
				@has_product2 = FactoryGirl.create(:has_product, product: @product2, app_user: @app_user, measure: @measure)
				@eaten_nutrient1 = FactoryGirl.create(:eaten_nutrient, has_product: @has_product1, nutrient: @nutrient1)
				@eaten_nutrient2 = FactoryGirl.create(:eaten_nutrient, has_product: @has_product1, nutrient: @nutrient2)
				@eaten_nutrient3 = FactoryGirl.create(:eaten_nutrient, has_product: @has_product1, nutrient: @nutrient3)
				@eaten_nutrient4 = FactoryGirl.create(:eaten_nutrient, has_product: @has_product2, nutrient: @nutrient4)
				@eaten_nutrient5 = FactoryGirl.create(:eaten_nutrient, has_product: @has_product2, nutrient: @nutrient3)
				@eaten_nutrient6 = FactoryGirl.create(:eaten_nutrient, has_product: @has_product2, nutrient: @nutrient2)
				@eaten_nutrient1.created_at = "2016-12-28 00:00:00"
				@eaten_nutrient1.save
				@eaten_nutrient2.created_at = "2016-12-28 00:00:00"
				@eaten_nutrient2.save
				@eaten_nutrient3.created_at = "2016-12-28 00:00:00"
				@eaten_nutrient3.save
				@eaten_nutrient4.created_at = "2016-12-28 00:00:00"
				@eaten_nutrient4.save
				@eaten_nutrient5.created_at = "2016-12-28 00:00:00"
				@eaten_nutrient5.save
				@eaten_nutrient6.created_at = "2016-12-28 00:00:00"
				@eaten_nutrient6.save
				get api_v1_eaten_nutrients_path, params: { uid: @app_user.uid, provider: @app_user.provider, token: @token.token, fecha: "2016-12-28" }
			end

			it { expect(response).to have_http_status(:ok) }

			it "should respond with the grouped values for the nutrinets" do
				json = JSON.parse(response.body)
				#pp json
				expect(json['data'].count).to eq(4)
			end
		end

		context "with no date and created nutrients" do
			before :each do
				@nutrient1 = FactoryGirl.create(:nutrient, measure: @measure)
				@nutrient2 = FactoryGirl.create(:nutrient, measure: @measure)
				@nutrient3 = FactoryGirl.create(:nutrient, measure: @measure)
				@nutrient4 = FactoryGirl.create(:nutrient, measure: @measure)
				@product1 = FactoryGirl.create(:product, measure: @measure, user: @user)
				@product2 = FactoryGirl.create(:product, nombre: "segundo", codigo: "5555555555", measure: @measure, user: @user)
				@has_product1 = FactoryGirl.create(:has_product, product: @product1, app_user: @app_user, measure: @measure)
				@has_product2 = FactoryGirl.create(:has_product, product: @product2, app_user: @app_user, measure: @measure)
				FactoryGirl.create(:eaten_nutrient, has_product: @has_product1, nutrient: @nutrient1)
				FactoryGirl.create(:eaten_nutrient, has_product: @has_product1, nutrient: @nutrient2)
				FactoryGirl.create(:eaten_nutrient, has_product: @has_product1, nutrient: @nutrient3)
				FactoryGirl.create(:eaten_nutrient, has_product: @has_product2, nutrient: @nutrient4)
				FactoryGirl.create(:eaten_nutrient, has_product: @has_product2, nutrient: @nutrient3)
				FactoryGirl.create(:eaten_nutrient, has_product: @has_product2, nutrient: @nutrient2)
				get api_v1_eaten_nutrients_path, params: { uid: @app_user.uid, provider: @app_user.provider, token: @token.token}
			end

			it { expect(response).to have_http_status(:ok) }

			it "should respond with the grouped values for the nutrinets" do
				json = JSON.parse(response.body)
				expect(json['data'].count).to eq(4)
			end
		end

		context "with no nutrients created" do
			before :each do
				@nutrient1 = FactoryGirl.create(:nutrient, measure: @measure)
				@nutrient2 = FactoryGirl.create(:nutrient, measure: @measure)
				@nutrient3 = FactoryGirl.create(:nutrient, measure: @measure)
				@nutrient4 = FactoryGirl.create(:nutrient, measure: @measure)
				@product1 = FactoryGirl.create(:product, measure: @measure, user: @user)
				@product2 = FactoryGirl.create(:product, nombre: "segundo", codigo: "5555555555", measure: @measure, user: @user)
				@has_product1 = FactoryGirl.create(:has_product, product: @product1, app_user: @app_user, measure: @measure)
				@has_product2 = FactoryGirl.create(:has_product, product: @product2, app_user: @app_user, measure: @measure)
				get api_v1_eaten_nutrients_path, params: { uid: @app_user.uid, provider: @app_user.provider, token: @token.token}
			end

			it { expect(response).to have_http_status(:not_found) }

			it "should respond with the grouped values for the nutrinets" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end
		end

		context "with invalid date" do
			before :each do
				@nutrient1 = FactoryGirl.create(:nutrient, measure: @measure)
				@nutrient2 = FactoryGirl.create(:nutrient, measure: @measure)
				@nutrient3 = FactoryGirl.create(:nutrient, measure: @measure)
				@nutrient4 = FactoryGirl.create(:nutrient, measure: @measure)
				@product1 = FactoryGirl.create(:product, measure: @measure, user: @user)
				@product2 = FactoryGirl.create(:product, nombre: "segundo", codigo: "5555555555", measure: @measure, user: @user)
				@has_product1 = FactoryGirl.create(:has_product, product: @product1, app_user: @app_user, measure: @measure)
				@has_product2 = FactoryGirl.create(:has_product, product: @product2, app_user: @app_user, measure: @measure)
				get api_v1_eaten_nutrients_path, params: { uid: @app_user.uid, provider: @app_user.provider, token: @token.token, fecha: "2015-12-02"}
			end

			it { expect(response).to have_http_status(:unprocessable_entity) }

			it "should respond with the grouped values for the nutrinets" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end
		end

		context "with invalid format date" do
			before :each do
				@nutrient1 = FactoryGirl.create(:nutrient, measure: @measure)
				@nutrient2 = FactoryGirl.create(:nutrient, measure: @measure)
				@nutrient3 = FactoryGirl.create(:nutrient, measure: @measure)
				@nutrient4 = FactoryGirl.create(:nutrient, measure: @measure)
				@product1 = FactoryGirl.create(:product, measure: @measure, user: @user)
				@product2 = FactoryGirl.create(:product, nombre: "segundo", codigo: "5555555555", measure: @measure, user: @user)
				@has_product1 = FactoryGirl.create(:has_product, product: @product1, app_user: @app_user, measure: @measure)
				@has_product2 = FactoryGirl.create(:has_product, product: @product2, app_user: @app_user, measure: @measure)
				get api_v1_eaten_nutrients_path, params: { uid: @app_user.uid, provider: @app_user.provider, token: @token.token, fecha: "2sadsad"}
			end

			it { expect(response).to have_http_status(:unprocessable_entity) }

			it "should respond with the grouped values for the nutrinets" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end
		end

	end
end