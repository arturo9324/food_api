class MyProductsController < ApplicationController

	before_action :set_product, except: [:index, :new, :create]
	before_action :authenticate_user!
	before_action :is_not_admin?
	#GET /products
	def index
		@products = @c_user.products.paginate(page: params[:page],per_page: 10).ultimos
		#obtener unicamente aquellos que haya creado la empresa
	end

	#GET /products/:id
	def show
		@nutrients = Nutrient.all
		@has_nutrient = HasNutrient.new
	end

	#GET /products/new
	def new
		@product = Product.new
	end

	#POST /products
	def create
		#raise params.to_yaml
		@product = @c_user.products.new(product_params)
		if @product.save
			redirect_to @product
		else
			render :new
		end
	end

	#GET /products/:id/edit
	def edit
	end

	#PUT/PATCH /products/:id
	def update
		redirect_to @product, notice: "Falta lógica actualización"
	end

	#DELETE /products/:id
	def destroy
		@product.destroy
		redirect_to products_path, notice: "El producto se ha eliminado"
	end

	private

	def product_params
		params.require(:product).permit(:nombre,:cantidad,:calorias,:codigo,:porciones,:image)
	end

	def product_num_params
		if params[:product][:porciones].to eq(1)
			return 1
		end
		return 0
	end
	def set_product
		if (Product.exists?(params[:id]))
			if @c_user == Product.find(params[:id]).user
				@product = Product.find(params[:id])
			else
				redirect_to products_path, alert: "No tienes permiso para acceder a este producto"
			end
		else
			error_resource_product
		end
	end
end