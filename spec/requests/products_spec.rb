require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :request do
	
	describe "GET /api/v1/products/:id" do

		before :each do
			@measure = FactoryGirl.create(:measure)
			@product = FactoryGirl.create(:product, codigo: "1234567890", measure: @measure)
			@portion = FactoryGirl.create(:portion, product: @product, measure: @measure)
			@product.publish!
			@user = FactoryGirl.create(:app_user)
			@token = FactoryGirl.create(:token, app_user: @user)
		end

		context "with valid code and token" do
			before :each do
				for i in 0..5
					@nutrients = FactoryGirl.create(:nutrient, measure: @measure)
					FactoryGirl.create(:has_nutrient, product: @product, nutrient: @nutrients)
				end
				get "/api/v1/products/#{@product.codigo}", params: { uid: @user.uid, provider: @user.provider, token: @token.token }
			end

			it { expect(response).to have_http_status(200) }

			it { expect(response.header['Content-Type']).to include 'application/json' }

			it "expect to have a content" do 
				json = JSON.parse(response.body)
				expect(json['data']['attributes']['codigo']).to eq(@product.codigo)
			end

			it "expect to respond with the related nutrients" do
				json =JSON.parse(response.body)
				#pp json
				expect(json['data']['relations']).to_not be_empty
			end
		end

		context "with invalid code" do
			before :each do
				get "/api/v1/products/0987654321", params: { uid: @user.uid, provider: @user.provider, token: @token.token }
			end

			it { expect(response).to have_http_status(:not_found) }

			it { expect(response.header['Content-Type']).to include "application/json" }

			it "expect to have an error" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end
		end

		context "with diferent token" do
			before :each do
				get "/api/v1/products/#{@product.codigo}", params: { uid: @user.uid, provider: @user.provider, token: "nada" }
			end

			it { expect(response).to have_http_status(:unauthorized) }

			it { expect(response.header['Content-Type']).to include "application/json" }

			it "expect to have an error" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end
		end

		context "with invalid token" do
			before :each do
				@token = FactoryGirl.create(:token, app_user: @user, expires_at: -1.month.from_now)
				@token.expires_at = -1.month.from_now
				@token.save
				#pp @token
				#pp @token.is_valid?
				get "/api/v1/products/#{@product.codigo}", params: { uid: @user.uid, provider: @user.provider, token: @token.token }
			end

			it { expect(response).to have_http_status(:unauthorized) }

			it { expect(response.header['Content-Type']).to include "application/json" }

			it "expect to have an error" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end
		end

		context "with no user" do
			before :each do
				get "/api/v1/products/#{@product.codigo}"
			end

			it { expect(response).to have_http_status(:unauthorized) }

			it { expect(response.header['Content-Type']).to include "application/json" }

			it "expect to have an error" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end
		end
	end

end