class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def error_resource_product
  	redirect_to products_path, notice: "El producto seleccionado no existe"
  end

  def error_has_nutrient
  	redirect_to @product, notice: "Selecciona correctamente los campos y llena la información solicitada"
  end

  protected

	def error_array(arreglo, status)
		@errors = @errors + arreglo
		response.status = status
		render "api/v1/errors"
	end

end
