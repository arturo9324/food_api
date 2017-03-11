require 'rails_helper'

RSpec.describe Api::V1::AppUsersController, type: :request do

	describe "POST /api/v1/app_users" do

		context "Create a new user" do

			before :each do
				@auth =  {uid: "12345", provider: "google", email: "123a@gmail.com", name: "ajdad"}
				post api_v1_app_users_path, params: { auth: @auth }
			end

			it { have_http_status(200) }

			it { change( AppUser, :count ).by(1) }

			it { expect(response.header['Content-Type']).to include 'application/json' }

			it "should respond with the created user" do
				json = JSON.parse(response.body)
				expect(json['data']['attributes']['email']).to eq(@auth[:email])
			end

			it "has to return the created token" do 
				json = JSON.parse(response.body)
				pp json
				expect(json['data']['token']).to_not be_empty
			end

		end

		context "With a created user" do
			before :each do
				@app_user = FactoryGirl.create(:app_user)
				@token = FactoryGirl.create(:token, app_user: @app_user)
				@token_value = @token.token
				@auth =  {uid: @app_user.uid, provider: @app_user.uid, email: @app_user.email, name: @app_user.name}
				post api_v1_app_users_path, params: { auth: @auth }
			end

			it { have_http_status(200) }

			it { change( AppUser, :count ).by(0) }

			it { expect(response.header['Content-Type']).to include 'application/json' }

			it "should respond with the same user" do
				json = JSON.parse(response.body)
				expect(json['data']['attributes']['email']).to eq(@app_user.email)
			end

			it "should respond with the same token" do
				json = JSON.parse(response.body)
				expect(json['data']['token']).to eq(@token_value)

			end
		end

		context "with a created user and a invalid token" do
			before :each do
				@app_user = FactoryGirl.create(:app_user)
				@token = FactoryGirl.create(:token, app_user: @app_user, expires_at: -1.second.from_now)
				@token_value = @token.token
				@auth =  {uid: @app_user.uid, provider: @app_user.uid, email: @app_user.email, name: @app_user.name}
				post api_v1_app_users_path, params: { auth: @auth }
			end

			it { have_http_status(200) }

			it { change( AppUser, :count ).by(0) }

			it { change( Token, :count ).by(1) }

			it { expect(response.header['Content-Type']).to include 'application/json' }

			it "should respond with diferent token" do
				json = JSON.parse(response.body)
				expect(json['data']['token']['token']).to_not eq(@token_value)
			end
		end

		context "with invalid params" do
			before :each do
				@auth =  { provider: "google", email: "123a@gmail.com", name: "ajdad"}
				post api_v1_app_users_path, params: { auth: @auth }
			end

			it { have_http_status(:unprocessable_entity) }

			it { change(AppUser, :count ).by(0) }

			it { change(Token, :count).by(0) }

			it { expect(response.header['Content-Type']).to include 'application/json' }

			it "should respond with diferent token" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end
		end
	end
end