class Api::V1::MasterApiController < ApplicationController
	##validar que se reciban los parametros correctos, como el APPID
	before_action :set_errors

	def set_errors
		@errors = []
	end

	def authenticate_user
		if params.has_key?(:token) and params.has_key?(:provider) and params.has_key?(:uid)
			@app_user = AppUser.where(uid: params[:uid], provider: params[:provider]).first
			if @app_user.tokens.any?
				@token = @app_user.tokens.last
			else
				error!("No se ha iniciado sesión", :unauthorized)
			end
			if params[:token] != @token.token
				error!("El token es incorrecto", :unauthorized)
			end
			unless @token.is_valid?
				error!("El token ha caducado", :unauthorized)
			end
		else
			error!("No se ha iniciado sesión", :unauthorized)
		end
	end
end