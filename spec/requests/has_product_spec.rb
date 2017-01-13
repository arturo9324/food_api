require 'rails_helper'

RSpec.describe Api::V1::HasProductsController, type: :request do

	describe "GET /api/v1/has_products" do
		before :each do
			@user = FactoryGirl.create(:app_user)
			@token = FactoryGirl.create(:token, app_user: @user)
		end

		context "without date" do
			before :each do
				@product = FactoryGirl.create(:product, nombre: "nuevo", codigo: "9876543210")
				FactoryGirl.create(:has_product, app_user: @user)
				FactoryGirl.create(:has_product, app_user: @user, product: @product)
				get api_v1_has_products_path, params: { uid: @user.uid, provider: @user.provider, token: @token.token }
			end

			it { expect(response).to have_http_status(:ok) }

			it "should respond with all the eaten products" do
				json = JSON.parse(response.body)
				expect(json['data']).to_not be_empty
			end
		end

		context "with valid date" do
			before :each do
				@product = FactoryGirl.create(:product, nombre: "nuevo", codigo: "9876543210")
				@has1 = FactoryGirl.create(:has_product, app_user: @user)
				@has2 = FactoryGirl.create(:has_product, app_user: @user, product: @product)
				@has1.created_at = "2016-12-28 00:00:00"
				@has1.save
				@has2.created_at = "2016-12-28 00:00:00"
				@has2.save
				get api_v1_has_products_path, params: { uid: @user.uid, provider: @user.provider, token: @token.token, fecha: "2016-12-28" }
			end

			it { expect(response).to have_http_status(:ok) }

			it "should respond with all the eaten products" do
				json = JSON.parse(response.body)
				expect(json['data']).to_not be_empty
			end
		end

		context "with invalid date" do
			before :each do
				@product = FactoryGirl.create(:product, nombre: "nuevo", codigo: "9876543210")
				get api_v1_has_products_path, params: { uid: @user.uid, provider: @user.provider, token: @token.token, fecha: "kasjhgsagdfvsgdv" }
			end

			it { expect(response).to have_http_status(:not_found) }

			it "should respond with all the eaten products" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end
		end 

		context "with greater date" do
			before :each do
				@product = FactoryGirl.create(:product, nombre: "nuevo", codigo: "9876543210")
				get api_v1_has_products_path, params: { uid: @user.uid, provider: @user.provider, token: @token.token, fecha: Date.tomorrow.to_s(:db) }
			end

			it { expect(response).to have_http_status(:unprocessable_entity) }

			it "should respond with all the eaten products" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end
		end

		context "with old date" do
			before :each do
				@product = FactoryGirl.create(:product, nombre: "nuevo", codigo: "9876543210")
				get api_v1_has_products_path, params: { uid: @user.uid, provider: @user.provider, token: @token.token, fecha: "2016-12-26" }
			end

			it { expect(response).to have_http_status(:unprocessable_entity) }

			it "should respond with all the eaten products" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end
		end

		context "with no products created" do
			before :each do
				@product = FactoryGirl.create(:product, nombre: "nuevo", codigo: "9876543210")
				get api_v1_has_products_path, params: { uid: @user.uid, provider: @user.provider, token: @token.token}
			end

			it { expect(response).to have_http_status(:partial_content) }

			it "should respond with all the eaten products" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end 
		end

	end

	describe "POST /api/v1/has_products" do

		before :each do
			@user = FactoryGirl.create(:app_user)
			@token = FactoryGirl.create(:token, app_user: @user)
		end

		context "with all valid" do
			before :each do
				@product = FactoryGirl.create(:product)
				@nutrient1 = FactoryGirl.create(:nutrient)
				@nutrient2 = FactoryGirl.create(:nutrient)
				FactoryGirl.create(:has_nutrient, product: @product, nutrient: @nutrient1)
				FactoryGirl.create(:has_nutrient, product: @product, nutrient: @nutrient2)
				@values = { porciones: 1.2, cantidad: 1.2, product: @product.codigo }
				@nutrients = { :"_#{@nutrient1.id}" => 0.3 , :"_#{@nutrient2.id}" => 0.8 }
				post api_v1_has_products_path, params: { uid: @user.uid, provider: @user.provider, token: @token.token, has: @values, nutrients: @nutrients } 
			end

			it { expect(response).to have_http_status(:ok) }

			it "should respond with the created has_product and its relations" do
				json = JSON.parse(response.body)
				#pp json
				expect(json['data']['attributes']).to_not be_empty
				expect(json['data']['relations']).to_not be_empty
			end 

			it "should respond with the created codo of has_product" do
				json = JSON.parse(response.body)
				expect(json['data']['attributes']['product_id']).to eq(@product.id)
			end

		end

		context "with invalid attributes" do
			before :each do
				@product = FactoryGirl.create(:product)
				@nutrient1 = FactoryGirl.create(:has_nutrient, product: @product)
				@nutrient2 = FactoryGirl.create(:has_nutrient, product: @product)
				@values = { porciones: "asasa",  product: @product.codigo }
				@nutrients = { :"_#{@nutrient1.id}" => 0.3 , :"_#{@nutrient2.id}" => 0.8 }
				post api_v1_has_products_path, params: { uid: @user.uid, provider: @user.provider, token: @token.token, has: @values, nutrients: @nutrients } 
			end

			it { expect(response).to have_http_status(:unprocessable_entity) }

			it "should respond with the error" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end 
		end

		context "with no nutrients created" do
			before :each do
				@product = FactoryGirl.create(:product)
				@values = { porciones: 1.2, cantidad: 1.2,  product: @product.codigo }
				post api_v1_has_products_path, params: { uid: @user.uid, provider: @user.provider, token: @token.token, has: @values, nutrients: {} } 
			end

			it { expect(response).to have_http_status(:unprocessable_entity) }

			it "should respond with the errors" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end 

		end

		context "with missed nutrients" do
			before :each do
				@product = FactoryGirl.create(:product)
				@nutrient1 = FactoryGirl.create(:has_nutrient, product: @product)
				@nutrient2 = FactoryGirl.create(:has_nutrient, product: @product)
				@values = { porciones: 1.2, cantidad: 1.2,  product: @product.codigo }
				post api_v1_has_products_path, params: { uid: @user.uid, provider: @user.provider, token: @token.token, has: @values, nutrients: {} } 
			end

			it { expect(response).to have_http_status(:unprocessable_entity) }

			it "should respond with the error" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end 
		end

		context "with no nutrient key" do
			before :each do
				@product = FactoryGirl.create(:product)
				@nutrient1 = FactoryGirl.create(:has_nutrient, product: @product)
				@nutrient2 = FactoryGirl.create(:has_nutrient, product: @product)
				@values = { porciones: 1.2, cantidad: 1.2,  product: @product.codigo }
				post api_v1_has_products_path, params: { uid: @user.uid, provider: @user.provider, token: @token.token, has: @values } 
			end

			it { expect(response).to have_http_status(:unprocessable_entity) }

			it "should respond with the error" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end 
		end

		context "with invlaid product code" do
			before :each do
				@product = FactoryGirl.create(:product)
				@nutrient1 = FactoryGirl.create(:has_nutrient, product: @product)
				@nutrient2 = FactoryGirl.create(:has_nutrient, product: @product)
				@values = { porciones: 1.2, cantidad: 1.2,  product: 122}
				post api_v1_has_products_path, params: { uid: @user.uid, provider: @user.provider, token: @token.token, has: @values } 
			end

			it { expect(response).to have_http_status(:not_found) }

			it "should respond with the error" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end 
		end
	end
end