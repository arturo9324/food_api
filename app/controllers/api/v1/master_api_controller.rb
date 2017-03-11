class Api::V1::MasterApiController < ApplicationController
	##validar que se reciban los parametros correctos, como el APPID
	before_action :set_errors
	skip_before_action :verify_authenticity_token

	def set_errors
		@errors = []
	end

	def authenticate_user
		if params.has_key?(:token) and params.has_key?(:provider) and params.has_key?(:uid)
			@app_user = AppUser.where(uid: params[:uid], provider: params[:provider]).first
			if not @app_user.nil?
				if @app_user.tokens.any?
					@token = @app_user.tokens.last
				else
					error!("No se ha iniciado sesión", :unauthorized)
					return
				end
				if params[:token] != @token.token
					error!("El token es incorrecto", :unauthorized)
					return
				end
				unless @token.is_valid?
					error!("El token ha caducado", :unauthorized)
					return
				end
			else
				error!("El usuario no existe", :unauthorized)
				return
			end
		else
			error!("No se ha iniciado sesión", :unauthorized)
			return
		end
	end

	def valid_date(date)
		require 'date'
		begin 
			@date = Date.parse(date)
		rescue
			@date = nil
		end
	end
end