class Api::V1::EatenNutrientsController < Api::V1::MasterApiController
	before_action :authenticate_user

	def index
		if params.has_key?(:fecha)
			valid_date(params[:fecha].to_s)
			if @date.nil?
				error!("Envia una fecha valida", :not_found)
				return
			end
			if @date <= Date.today and @date >= Date.parse(MIN_DATE)
				@eaten = @app_user.eaten_nutrients.suma.grupo.fecha(@date)
			else
				error!("Envia una fecha valida", :unprocessable_entity)
				return
			end
		else
			@eaten = @app_user.eaten_nutrients.suma.grupo.hoy
		end

		if @eaten.empty?
			error!("No se encontraron nutrientes registrados", :partial_content)
			return
		end
		render "/api/v1/eaten_nutrients/show"
	end
	
end