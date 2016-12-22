class Api::V1::BestNutrientValuesController < Api::V1::MasterApiController
	before_action :authenticate_user
	before_action :select_all!

	def index
		if @my_nutrients.empty?
			error!("Debes registrar tu información personal para poder recibir recomendaciones",:not_found)
			return
		end
		render "api/v1/best_nutrient_values/show"
	end

	def create
		@requests = []
		if params.has_key?(:best)
			@values = params[:best]
			@nutrients = Nutrient.all
			@nutrients.each do |n|
				unless @values.has_key?(:"_#{n.id}")
					error!("Envia todos los nutrientes", :unprocessable_entity)
					return
				end
				unless @values[:"_#{n.id}"].has_key?(:optimo) || @values[:"_#{n.id}"].has_key?(:maximo) || @values[:"_#{n.id}"].has_key?(:minimo)
					error!("Error de formato de nutrientes", :unprocessable_entity)
					return
				end
				req = @app_user.best_nutrient_values.new(nutrient: n, optimo: @values[:"_#{n.id}"][:optimo], maximo: @values[:"_#{n.id}"][:maximo], minimo: @values[:"_#{n.id}"][:minimo])
				unless req.valid?
					error!(req.errors.full_messages, :unprocessable_entity)
					return
				end
				@requests << req
			end
		else
			error!("No se envio la información de los nutrientes", :unprocessable_entity)
			return
		end
		delete_all!
		success = @requests.each(&:save)
		unless success.any?
			error!("Ocurrio un error mientras se registraban los nutrientes", :unprocessable_entity)
			return
		end
		unless success.all?
			@errors << "No se pudieron registrar correctamente todos los registros, por favor vuelve a intentarlo"
			render "api/v1/best_nutrient_values/show", status: :partial_content
			return
		end
		render "api/v1/best_nutrient_values/show"
	end

	private

	def select_all!
		@my_nutrients = BestNutrientValue.where(app_user: @app_user)
	end

	def delete_all!
		unless @my_nutrients.empty?
			@my_nutrients.each(&:destroy)
		end
	end
end