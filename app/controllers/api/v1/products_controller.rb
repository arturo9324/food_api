class Api::V1::ProductsController < Api::V1::MasterApiController
	before_action :authenticate_user
	before_action :set_product
	
	#GET /api/v1/products/:id
	def show
	end

	private

	def set_product
		if not (Product.where("codigo = ?", params[:id]).take.nil?)
			@product = Product.where("codigo = ?",params[:id]).take
			unless @product.published?
				error!("El producto buscado no esta disponible", :not_found)
			end
		else
			error!("El producto buscado no existe", :not_found)
		end
	end

end