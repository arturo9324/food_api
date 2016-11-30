class Api::V1::InfoAppUsersController < Api::V1::MasterApiController 
	before_action :authenticate_user
	def index
	end

	def create
		error!(params[:info].to_yaml,:unprocesable_entity)
	end

	def update
	end

	private

	def info_params
		params.require(:info).permit(:fecha_nacimiento, :peso, :estatura, :sexo, :max_calories, :min_calories, :embarazo, :lactancia)
	end
end