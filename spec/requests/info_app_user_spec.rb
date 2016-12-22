require 'rails_helper'

RSpec.describe Api::V1::InfoAppUsersController, type: :request do

	describe "GET /api/v1/info_app_users" do
		before :each do
			@token = FactoryGirl.create(:token)
			@user = @token.app_user
		end

		context "with no info" do
			before :each do
				get api_v1_info_app_users_path, params: { uid: @user.uid, provider: @user.provider, token: @token.token }
			end

			it { expect(response).to have_http_status(:not_found) }

			it "should respond with the error" do
				json = JSON.parse(response.body)
				expect(json["errors"]).to_not be_empty
			end
		end

		context "with info and no diseases" do
			before :each do
				@info = FactoryGirl.create(:info_app_user, app_user: @user )
				get api_v1_info_app_users_path, params: { uid: @user.uid, provider: @user.provider, token: @token.token }
			end

			it { expect(response).to have_http_status(200) }

			it "should return the user info" do
				json = JSON.parse(response.body)
				expect(json['data']['attributes']['fecha_nacimiento']).to eq(@info.fecha_nacimiento.to_s(:db))
			end
		end

		context "whit info and deseases" do
			before :each do
				@info = FactoryGirl.create(:info_app_user, app_user: @user )
				for i in 1..3
					FactoryGirl.create(:has_disease, info_app_user: @info)
				end
				get api_v1_info_app_users_path, params: { uid: @user.uid, provider: @user.provider, token: @token.token }
			end

			it { expect(response).to have_http_status(200) }

			it "should return the user info" do
				json = JSON.parse(response.body)
				expect(json['data']['attributes']['fecha_nacimiento']).to eq(@info.fecha_nacimiento.to_s(:db))
			end

			it "should respond whith the created diseases" do
				json = JSON.parse(response.body)
				expect(json['data']['relations']).to_not be_empty
			end
		end
	end

	describe "POST /api/v1/info_app_users" do
		before :each do
			@token = FactoryGirl.create(:token)
			@user = @token.app_user
		end

		context "with valid params and no diseases" do
			before :each do
				@info_count = InfoAppUser.count
				@info = {fecha_nacimiento: -11.years.from_now, peso: 40, estatura: 35, sexo: 0, max_calorias: 50, min_calorias: 30, embarazo: 0, lactancia: 1 }
				post api_v1_info_app_users_path, params: {info: @info, uid: @user.uid, provider: @user.provider, token: @token.token }
			end

			it { expect(response).to have_http_status(200) }

			it { expect(@info_count + 1).to eq(InfoAppUser.count)  }

			it { expect(response.header['Content-Type']).to include 'application/json' }

			it "should respond with the created user info" do
				json = JSON.parse(response.body)
				#pp json.to_yaml
				expect(json['data']['attributes']['app_user_id']).to eq(@user.id)
			end
		end

		context "whith valid params and valid diseases" do
			before :each do
				@diseases = []
				for i in 0..3
					dis = FactoryGirl.create(:disease)
					@diseases << dis.id 
				end
				@info_count = InfoAppUser.count
				@info = {fecha_nacimiento: -11.years.from_now, peso: 40, estatura: 35, sexo: 0, max_calorias: 50, min_calorias: 30, embarazo: 0, lactancia: 1 }
				post api_v1_info_app_users_path, params: {info: @info, uid: @user.uid, provider: @user.provider, token: @token.token, diseases: @diseases }
			end

			it { expect(response).to have_http_status(200) }

			it { expect(@info_count + 1).to eq(InfoAppUser.count)  }

			it { expect(response.header['Content-Type']).to include 'application/json' }

			it "should respond with the created user info" do
				json = JSON.parse(response.body)
				#pp json.to_yaml
				expect(json['data']['attributes']['app_user_id']).to eq(@user.id)
			end

			it "should respond with the created diseases" do
				json = JSON.parse(response.body)
				expect(json['data']['relations']['has_diseases']).to_not be_empty
			end
		end

		context "whit valid params and invalid diseases" do
			before :each do
				@diseases = []
				for i in 1..3
					dis = FactoryGirl.create(:disease)
					@diseases << dis.id
					@diseases << dis.id+1
				end
				@info_count = InfoAppUser.count
				@info = {fecha_nacimiento: -11.years.from_now, peso: 40, estatura: 35, sexo: 0, max_calorias: 50, min_calorias: 30, embarazo: 0, lactancia: 1 }
				post api_v1_info_app_users_path, params: {info: @info, uid: @user.uid, provider: @user.provider, token: @token.token, diseases: @diseases }
			end

			it { expect(response).to have_http_status(:partial_content) }

			it { expect(@info_count + 1).to eq(InfoAppUser.count)  }

			it { expect(response.header['Content-Type']).to include 'application/json' }

			it "should respond with the created user info" do
				json = JSON.parse(response.body)
				expect(json['data']['attributes']['app_user_id']).to eq(@user.id)
			end

			it "should not respond with relations and explain the error" do
				json = JSON.parse(response.body)
				expect(json['data']['relations']).to be_nil
				expect(json['errors']).to_not be_empty
			end

		end

		context "with invalid params" do
			before :each do
				@info_count = InfoAppUser.count
				@info = {fecha_nacimiento: -11.years.from_now, peso: 40, estatura: "nueva", sexo: 0, embarazo: 0, lactancia: 1 }
				post api_v1_info_app_users_path, params: {info: @info, uid: @user.uid, provider: @user.provider, token: @token.token }
			end

			it { expect(response).to have_http_status(:unprocessable_entity) }

			it { expect(@info_count).to eq(InfoAppUser.count)  }

			it { expect(response.header['Content-Type']).to include 'application/json' }

			it "should respond with error" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end
		end
	end

	describe "POST-PUT/PATCH /api/v1/info_app_users" do
		before :each do
			@token = FactoryGirl.create(:token)
			@user = @token.app_user
			@info = FactoryGirl.create(:info_app_user, app_user: @user )
			@diseases = []
			for i in 1..2
				dis = FactoryGirl.create(:disease)
				@diseases << dis.id
			end
		end

		context "whith no diseases" do
			before :each do
				@info_count = InfoAppUser.count
				@info_array = { peso: 100, embarazo: 1, lactancia: 0 }
				post api_v1_info_app_users_path, params: {info: @info_array, uid: @user.uid, provider: @user.provider, token: @token.token }
			end

			it { expect(response).to have_http_status(200) }

			it { expect(@info_count).to eq(InfoAppUser.count) }

			it { expect(response.header['Content-Type']).to include "application/json" }

			it "should respond whit the updated info" do
				json = JSON.parse(response.body)
				expect(json['data']['attributes']['peso']).to eq(@info_array[:peso])
			end

		end

		context "whit new diseases" do
			before :each do
				@info_count = InfoAppUser.count
				@diseases = []
				for i in 1..3
					dis = FactoryGirl.create(:disease)
					@diseases << dis.id
				end
				@info_array = { peso: 100, embarazo: 1, lactancia: 0 }
				post api_v1_info_app_users_path, params: {info: @info_array, diseases: @diseases, uid: @user.uid, provider: @user.provider, token: @token.token }
			end

			it { expect(response).to have_http_status(200) }

			it { expect(@info_count).to eq(InfoAppUser.count) }

			it { expect(response.header['Content-Type']).to include "application/json" }

			it "should respond with the updated info" do
				json = JSON.parse(response.body)
				expect(json['data']['attributes']['peso']).to eq(@info_array[:peso])
			end

			it "should respond with the created diseases" do
				json = JSON.parse(response.body)
				expect(json['data']['relations']).to_not be_empty
			end
		end

		context "whit repeted diseases" do
			before :each do
				@info_count = InfoAppUser.count
				@diseases = []
				for i in 1..3
					dis = FactoryGirl.create(:disease)
					FactoryGirl.create(:has_disease, info_app_user: @info, disease: dis)
					@diseases << dis.id
				end
				@info_array = { peso: 100, embarazo: 1, lactancia: 0 }
				post api_v1_info_app_users_path, params: {info: @info_array, diseases: @diseases, uid: @user.uid, provider: @user.provider, token: @token.token }
			end

			it { expect(response).to have_http_status(200) }

			it { expect(@info_count).to eq(InfoAppUser.count) }

			it { expect(response.header['Content-Type']).to include "application/json" }

			it "should respond with the updated info" do
				json = JSON.parse(response.body)
				expect(json['data']['attributes']['peso']).to eq(@info_array[:peso])
			end

			it "should respond with the created diseases" do
				json = JSON.parse(response.body)
				expect(json['data']['relations']).to_not be_empty
			end
		end

		context "whith incorrect diseases" do
			before :each do
				@info_count = InfoAppUser.count
				@diseases = []
				for i in 1..3
					dis = FactoryGirl.create(:disease)
					@diseases << dis.id
					@diseases << dis.id + 1 
				end
				@info_array = { peso: 100, embarazo: 1, lactancia: 0 }
				post api_v1_info_app_users_path, params: {info: @info_array, diseases: @diseases, uid: @user.uid, provider: @user.provider, token: @token.token }
			end

			it { expect(response).to have_http_status(:partial_content) }

			it { expect(@info_count).to eq(InfoAppUser.count) }

			it { expect(response.header['Content-Type']).to include "application/json" }

			it "should respond with the updated info" do
				json = JSON.parse(response.body)
				expect(json['data']['attributes']['peso']).to eq(@info_array[:peso])
			end

			it "should respond with the created diseases" do
				json = JSON.parse(response.body)
				expect(json['data']['relations']).to be_nil
			end

			it "should respodn with the error message" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end 
		end

		context "with incorrect diseases but created" do
			before :each do
				@info_count = InfoAppUser.count
				@diseases = []
				for i in 1..3
					dis = FactoryGirl.create(:disease)
					FactoryGirl.create(:has_disease, info_app_user: @info, disease: dis)
					@diseases << dis.id
					@diseases << dis.id + 1 
				end
				@info_array = { peso: 100, embarazo: 1, lactancia: 0 }
				post api_v1_info_app_users_path, params: {info: @info_array, diseases: @diseases, uid: @user.uid, provider: @user.provider, token: @token.token }
			end

			it { expect(response).to have_http_status(:partial_content) }

			it { expect(@info_count).to eq(InfoAppUser.count) }

			it { expect(response.header['Content-Type']).to include "application/json" }

			it "should respond with the updated info" do
				json = JSON.parse(response.body)
				expect(json['data']['attributes']['peso']).to eq(@info_array[:peso])
			end

			it "should respond with the created diseases" do
				json = JSON.parse(response.body)
				expect(json['data']['relations']).to_not be_empty
			end

			it "should respodn with the error message" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end 
		end

		context "whith created diseases for delete" do
			before :each do
				@info_count = InfoAppUser.count
				for i in 1..3
					dis = FactoryGirl.create(:disease)
					FactoryGirl.create(:has_disease, info_app_user: @info, disease: dis)
				end
				@info_array = { peso: 100, embarazo: 1, lactancia: 0 }
				post api_v1_info_app_users_path, params: {info: @info_array, uid: @user.uid, provider: @user.provider, token: @token.token }
			end

			it { expect(response).to have_http_status(:ok) }

			it { expect(@info_count).to eq(InfoAppUser.count) }

			it { expect(response.header['Content-Type']).to include "application/json" }

			it "should respond with the updated info" do
				json = JSON.parse(response.body)
				expect(json['data']['attributes']['peso']).to eq(@info_array[:peso])
			end

			it "should respond with the created diseases" do
				json = JSON.parse(response.body)
				expect(json['data']['relations']).to be_nil
			end

			it "should respodn with the error message" do
				json = JSON.parse(response.body)
				expect(json['errors']).to be_empty
			end 

			it "should change count by 0" do
				expect(HasDisease.where(info_app_user: @info).count).to eq(0)
			end
		end

		context "whith invalid params" do
			before :each do
				@info_count = InfoAppUser.count
				@info_array = { peso: 10000000, embarazo: "siempre", lactancia: "10", fecha_nacimiento: 1.years.from_now }
				post api_v1_info_app_users_path, params: {info: @info_array, uid: @user.uid, provider: @user.provider, token: @token.token }
			end

			it { expect(response).to have_http_status(:unprocessable_entity) }

			it { expect(@info_count).to eq(InfoAppUser.count) }

			it { expect(response.header['Content-Type']).to include "application/json" }

			it "should respodn with the error message" do
				json = JSON.parse(response.body)
				expect(json['errors']).to_not be_empty
			end 
		end

		context "with invalid diseases" do
			before :each do
				@info_count = InfoAppUser.count
				@diseases = [1,2,3,4]
				@info_array = { peso: 100, embarazo: "siempre", lactancia: "10" }
				post api_v1_info_app_users_path, params: {info: @info_array, diseases: @diseases, uid: @user.uid, provider: @user.provider, token: @token.token }
			end

			it { expect(response).to have_http_status(:partial_content) }

			it { expect(@info_count).to eq(InfoAppUser.count) }

			it { expect(response.header['Content-Type']).to include "application/json" }

			it "should respodn with the error message" do
				json = JSON.parse(response.body)
				#pp json.to_yaml
				expect(json['errors']).to_not be_empty
			end 
		end
	end
end