class Api::V1::ProductsController < Api::V1::MasterApiController
	before_action :set_errors
	before_action :set_product
	#GET /api/v1/products/:id
	def show
	end

	private

	def set_product
		if not (Product.where("codigo = ?", params[:id]).take.nil?)
			@product = Product.where("codigo = ?",params[:id]).take
		else
			error!("El producto buscado no existe", :unprocessable_entity)
		end
	end

end