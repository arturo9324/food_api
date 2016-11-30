class Api::V1::InfoAppUsersController < Api::V1::MasterApiController 
	before_action :authenticate_user
	def index
	end

	def create
		@info = @app_user.info_app_user.build(info_params)
		if @info.save
			render "api/v1/app_users/show"
		else
			error_array!(@info.errors.full_messages,:unprocesable_entity)
		end
	end

	def update
	end

	private

	def info_params
		params.require(:info).permit(:fecha_nacimiento, :peso, :estatura, :sexo, :max_calories, :min_calories, :embarazo, :lactancia)
	end
end