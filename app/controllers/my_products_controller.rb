class MyProductsController < ApplicationController

	before_action :set_product, except: [:index, :new, :create]
	before_action :authenticate_user!
	before_action :is_not_admin?
	before_action :set_measure, only: [:create, :update]
	before_action :set_measures, only: [:new, :edit]
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
		@product.build_portion
	end

	#POST /products
	def create
		#raise params.to_yaml
		@product = @c_user.products.new(product_params)
		@product.measure = @measure
		if @product.save
			if @product.porciones
				@portion = @product.build_portion(portion_params)
				@portion.measure = @measure
				unless @portion.save
					set_measures()
					render :edit
					return 
				end
			end
			redirect_to @product
		else
			render :new
		end
	end

	#GET /products/:id/edit
	def edit
		if @product.portion.nil?
			@product.build_portion
		end
	end

	#PUT/PATCH /products/:id
	def update
		if @product.update(product_params)
			if @product.porciones
				if @product.portion.nil?
					@portion = @product.build_portion(portion_params)
					@portion.measure = @measure
					unless @portion.save
						set_measures()
						render :edit
						return
					end
				else
					@portion =  @product.portion
					@portion.measure = @measure
					unless @portion.update(portion_params)
						set_measures()
						render :edit
						return
					end
				end
			else
				unless @product.portion.nil?
					portion = @product.portion
					portion.destoy
				end
			end
			redirect_to @product, notice: "Se ha actualizado correctamente"
		else
			set_measures()
			render :edit
			return
		end
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

	def portion_params
		params[:product].require(:portion).permit(:mesure, :porcion, :cantidad, :equivalencia)
	end

	def set_measures
		@measures = Measure.all
	end

	def set_measure
		if params[:product].has_key?(:measure)
			if Measure.exists?(params[:product][:measure])
				@measure = Measure.find(params[:product][:measure])
			else
				@measure = nil
			end
		else@measure = nil
		end
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