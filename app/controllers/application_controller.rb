class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :login?


  def error_resource_product
  	redirect_to products_path, notice: "El producto seleccionado no existe"
  end

  def error_has_nutrient
  	redirect_to @product, notice: "Selecciona correctamente los campos y llena la información solicitada"
  end

  def is_not_admin?
    redirect_to root_path, alert: "No estas autorizado para realizar esta acción" if @c_user.admin?
  end

  def authenticate_user
    redirect_to(new_user_session_path, alert: "Tienes que iniciar sesión") unless user_signed_in?
  end

  def login?
    if user_signed_in?
      @c_user = current_user
    end
  end

  protected

	def error_array(arreglo, status)
		@errors = @errors + arreglo
		response.status = status
		render "api/v1/errors"
	end

  def error!(message,status)
    @errors << message
    response.status = status
    render "api/v1/errors"
  end

end
