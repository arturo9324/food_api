class MyProductsController < ApplicationController

	before_action :set_product, except: [:index, :new, :create]
	before_action :authenticate_user!
	before_action :is_not_admin?
	#GET /products
	def index
		@products = Product.paginate(page: params[:page],per_page: 10).ultimos
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
		@product = Product.new(product_params)
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

	#DELETE /products/:idd
	def destroy
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
			@product = Product.find(params[:id])
		else
			error_resource_product
		end
	end
end