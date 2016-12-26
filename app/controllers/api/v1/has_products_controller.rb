class Api::V1::HasProductsController < Api::V1::MasterApiController
	before_action :authenticate_user
	before_action :set_relations, only: [:create]

	def index
		if params.has_key?(:fecha)
			valid_date(params[:fecha].to_s)
			if @date.nil?
				error!("Envia una fecha valida", :not_found)
			else
				if @date <= Date.today

				else
					error!("Envia una fecha valida", :unprocesable_entity)
					return
				end
			end
		else
			@has = HasProduct.hoy
		end
		render "/api/v1/has_products/show"
	end

	def create
		@has = @app_user.has_products.new(has_products_params)
		@has.product = @product
		if @has.save
			render "/api/v1/has_products/show"
		else
			error_array!(@has.errors.full_messages, :unprocesable_entity)
		end
	end

	private

	def has_products_params
		params.require(:has).permit(:porciones, :cantidad)
	end

	def set_relations
		if params[:has].has_key?(:product)
			@product = Product.find_by(:codigo => params[:has][:product])
			if @product.nil?
				error!("El producto solicitado no esiste", :not_found)
				return
			end
		else
			error!("No se ha enviado el codigo del producto", :unprocesable_entity)
			return
		end
	end

	def valid_date(date)
		require 'date'
		begin 
			@date = Date.parse(date)
		rescue
			@date = nil
		end
	end

end