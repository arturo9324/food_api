class Api::V1::AppUsersController < Api::V1::MasterApiController

	def create
		if ! params[:auth]
			raise "error"
		else
			@user = AppUser.from_omniauth(app_users_params)
			if @user.tokens.any?
				if @user.tokens.last.is_valid?
					@token = @user.tokens.create
				else
					@token = @user.token.last
				end
			else
				@token = @user.tokens.create
			end
			render "api/v1/app_users/show"
		end
	end

	private

	def app_users_params
		params.require(:auth).permit(:provider, :uid, :email, :name)
	end                        

	def set_app_user

	end

end 
