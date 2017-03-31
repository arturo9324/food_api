class Api::V1::AppUserCaloriesController < Api::V1::MasterApiController
	before_action :authenticate_user
	
	def index
		if params.has_key?(:fecha)
			valid_date(params[:fecha].to_s)
			if @date.nil?
				error!("Envia una fecha valida", :unprocessable_entity)
				return
			end 
			if @date <= Date.today and @date >= Date.parse(MIN_DATE)
				@calories = @app_user.app_user_calories.suma.grupo.fecha(@date)
			else
				error!("Envia una fecha valida", :unprocessable_entity)
				return
			end
		else
			@calories = @app_user.app_user_calories.suma.grupo.hoy
		end
		if @calories.empty?
			error!("No se registro ningun gasto calórico en este día", :not_found)
			return
		end 
		render "/api/v1/calories/show_calories"
	end

	def create
		@calories = @app_user.app_user_calories.new(app_user_calories_params)
		if @calories.save
			render "/api/v1/calories/show"
		else
			error_array!(@calories.errors.full_messages, :unprocessable_entity)
			return
		end
	end

	private
	def app_user_calories_params
		params.fetch(:calories, {}).permit(:gasto)
	end
end