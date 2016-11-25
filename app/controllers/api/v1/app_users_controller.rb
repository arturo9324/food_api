class Api::V1::AppUsersController < Api::V1::MasterApiController

	def create
		if ! params[:auth]
			raise "error"
		else
			@user = AppUser.from_omniauth(app_users_params)
<<<<<<< HEAD
=======
			if @user.tokens.any?
				if @user.tokens.last.is_valid?
					@token = @user.tokens.create
				else
					@token = @user.token.last
				end
			else
				@token = @user.tokens.create
			end
>>>>>>> 34854c68899985a9e68582cee0d9201d3ac60f1f
			render "api/v1/app_users/show"
		end
	end

<<<<<<< HEAD
	

# PATCH/PUT /users/1.json
	def update
	   if @user.update(user_params)
	    respond_with({'status':'success'})
	   else
	    respond_with({'status':'error'})
	   end
	end

=======
>>>>>>> 34854c68899985a9e68582cee0d9201d3ac60f1f
	private

	def app_users_params
		params.require(:auth).permit(:provider, :uid, :email, :name)
	end                        

	def set_app_user

	end

end 
