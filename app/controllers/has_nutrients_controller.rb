class HasNutrientsController < ApplicationController

	before_action :set_product
	before_action :set_values
	before_action :select_all!

	def create
		if validates_and_save_nutrients
			redirect_to product_path(@product)
		end
	end

	private

	def validates_and_save_nutrients
		n_id = []
		records = []
		nutrients = @values[:identifiers]
		nutrient_values =  @values[:values]
		#reocorrer todo el arreglo de ids de nutrientes
		nutrients.each do |nutrient|
			unless Nutrient.exists?(nutrient)
				error_has_nutrient
			end
			n_id << nutrient
		end
		#recorrer todo el arreglo de valores y comprobar la existencia de las llaves
		n_id.each do |id|
			unless nutrient_values.key?(id)
				error_has_nutrient
			end
		end

		n_id.each do |id|
			has = HasNutrient.new(product: @product, nutrient: Nutrient.find(id), cantidad: nutrient_values[id])
			if not has.valid?(:cantidad)
				error_has_nutrient
			else
				records << has
			end 
		end
		delete_all!
		success = records.each(&:save)
		unless success.all?
			redirect_to @product, notice: "Ocurrio un error mientras se guardaban los datos, por favor vuelve a registar los nutrientes" and return
		end
		true
	end

	private

	def set_values
		@values = params[:nutrients]
	end

	def select_all!
		@has_nutrients =  HasNutrient.where("product_id = ? ", @product)
	end

	def delete_all!
		@has_nutrients.each do |has_nutrient|
			has_nutrient.destroy
		end
	end

	 def set_product
		if (Product.exists?(params[:product_id]))
			@product = Product.find(params[:product_id])
		else
			error_resource_product
		end
	end
end