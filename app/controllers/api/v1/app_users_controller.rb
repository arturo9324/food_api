class Api::V1::AppUsersController < Api::V1::MasterApiController

	def create
		if ! params[:auth]
			raise "error"
		else
			@user = AppUser.from_omniauth(app_users_params)
			render "api/v1/app_users/show"
		end
	end

	

# PATCH/PUT /users/1.json
	def update
	   if @user.update(user_params)
	    respond_with({'status':'success'})
	   else
	    respond_with({'status':'error'})
	   end
	end

	private

	def app_users_params
		params.require(:auth).permit(:provider, :uid, :email, :name)
	end                        

	def set_app_user

	end

end 
