class Api::V1::HasProductsController < Api::V1::MasterApiController
	before_action :authenticate_user
	before_action :set_relations, only: [:create]
	before_action :validate_nutrients_params, only: [:create]

	def index
		if params.has_key?(:fecha)
			valid_date(params[:fecha].to_s)
			if @date.nil?
				error!("Envia una fecha valida", :unprocessable_entity)
				return
			else
				if @date <= Date.today and @date >= Date.parse(MIN_DATE)
					@has = @app_user.has_products.fecha(@date)
				else
					error!("Envia una fecha valida", :unprocessable_entity)
					return
				end
			end
		else
			@has = @app_user.has_products.hoy
		end
		if @has.empty? or @has.nil?
			error_array!(["No se encontraron productos"], :not_found)
			return
		end
		render "/api/v1/has_products/show"
	end

	def create
		@has = @app_user.has_products.new(has_products_params)
		@has.product = @product
		if @has.save
			@nutrient_values.each do |n|
				n.has_product = @has
				unless n.save
					@errors << "Ocurrio un error mientras se almacenaba #{n.nutrient}"
				end
			end
			render "/api/v1/has_products/show_create"
		else
			error_array!(@has.errors.full_messages, :unprocessable_entity)
		end
	end

	private

	def validate_nutrients_params
		@nutrients = @product.nutrients
		if @nutrients.empty?
			error!("No se puede procesar este alimento error en la base de datos.", :unprocessable_entity)
			return 
		end
		@nutrient_values = []
		#pp params[:nutrients].to_yaml
		#raise @nutrients.to_yaml
		if params.has_key?(:nutrients)
			@nutrients.each do |n|
				unless params[:nutrients].has_key?(:"_#{n.id}")
					error!("No has enviado todos los nutrients de este producto", :unprocessable_entity)
					return
				end
				record = EatenNutrient.new(nutrient: n, cantidad: params[:nutrients][:"_#{n.id}"])
				unless record.valid?
					error!("Envia valores validos para los nutrientes",:unprocessable_entity)
					return
				end
				@nutrient_values << record
			end
		else
			error!("No has enviado los nutrientes del producto", :unprocessable_entity)
			return
		end
	end

	def has_products_params
		params.fetch(:has, {}).permit(:porciones, :cantidad, :calories)
	end

	def set_relations
		#raise params.to_yaml
		if params[:has].has_key?(:product)
			@product = Product.find_by(:codigo => params[:has][:product])
			if @product.nil?
				error!("El producto solicitado no esiste", :not_found)
				return
			end
		else
			error!("No se ha enviado el codigo del producto", :unprocessable_entity)
			return
		end
	end

end