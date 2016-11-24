require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :request do
	
	describe "GET /api/v1/products/:id" do

		context "with valid code" do
			before :each do
				@product = FactoryGirl.create(:product, codigo: "1234567890")
				for i in 0..5
					@nutrients = FactoryGirl.create(:nutrient)
					FactoryGirl.create(:has_nutrient, product: @product, nutrient: @nutrient)
				end
				get "/api/v1/products/#{@product.codigo}"
			end

			it { expect(response).to have_http_status(200) }

			it { expect(response.header['Content-Type']).to include 'application/json' }

			it "expect to have a content" do 
				json = JSON.parse(response.body)
				expect(json['data']['attributes']['codigo']).to eq(@product.codigo)
			end

			it "expect to respond with the related nutrients" do
				json =JSON.parse(response.body)
				expect(json['data']['relations']).to_not be_empty
			end
		end

		context "with invalid code" do
			before :each do
				@product = FactoryGirl.create(:product, codigo: "1234578890")
				get "/api/v1/products/0987654321"
			end

			it { expect(response).to have_http_status(:unprocessable_entity) }

			it { expect(response.header['Content-Type']).to include "application/json" }

			it "expect to have an error" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end
		end
	end

end