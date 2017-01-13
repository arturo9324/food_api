class MyProductsController < ApplicationController

	
	before_action :authenticate_user!
	before_action :is_not_admin?
	before_action :set_product, except: [:index, :new, :create]
	before_action :set_measure_product, only: [:create, :update]
	before_action :set_measure_portion, only: [:create, :update]
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
			@portion = @product.build_portion(portion_params)
			@portion.measure = @p_measure
			unless @portion.save
				set_measures()
				render :edit
				return 
			end
			@product.publish!
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
		#raise params.to_yaml
		if @product.update(product_params)
			if @product.portion.nil?
				@portion = @product.build_portion(portion_params)
				@portion.measure = @p_measure
				unless @portion.save
					if @product.may_unpublish?
						@product.unpublish!
					end
					set_measures()
					render :edit
					return
				end
			else
				@portion =  @product.portion
				@portion.measure = @p_measure
				unless @portion.update(portion_params)
					set_measures()
					render :edit
					return
				end
			end
			if @product.may_publish?
				@product.publish!
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
		params.fetch(:product, {}).permit(:nombre,:cantidad,:calorias,:codigo,:image)
	end

	def portion_params
		params[:product].fetch(:portion, {}).permit(:porcion, :cantidad, :equivalencia)
	end

	def set_measures
		@measures = Measure.all
	end

	def set_measure_product
		if params[:product].has_key?(:measure)
			if Measure.exists?(params[:product][:measure])
				@measure = Measure.find(params[:product][:measure])
			else
				@measure = nil
			end
		else
			@measure = nil
		end
	end

	def set_measure_portion
		if params[:product][:portion].has_key?(:measure)
			if Measure.exists?(params[:product][:portion][:measure])
				@p_measure = Measure.find(params[:product][:portion][:measure])
			else
				@p_measure = nil
			end
		else
			@p_measure = nil
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