class Api::V1::AppUsersController < Api::V1::MasterApiController

	def create
		if ! params[:auth]
			error!("No se han recibido los parametros en el formato correcto", :unprocessable_entity)
		else
			@user = AppUser.from_omniauth(app_users_params)
			if @user.persisted?
				if @user.tokens.any?
					if @user.tokens.last.is_valid?
						@token = @user.tokens.create
					else
						@token = @user.tokens.last
					end
				else
					@token = @user.tokens.create
				end
			else
				error_array!(@user.errors.full_messages, :unprocessable_entity)
			end
			render "api/v1/app_users/show"
		end
	end

	private

	def app_users_params
		params.require(:auth).permit(:provider, :uid, :email, :name)
	end 

end 
