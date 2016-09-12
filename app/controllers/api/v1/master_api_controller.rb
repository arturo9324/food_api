class Api::V1::MasterApiController < ApplicationController
	##validar que se reciban los parametros correctos, como el APPID

	def set_errors
		@errors = []
	end

	def error!(message, status)
		@errors << message
		response.status = status
		render "/api/v1/errors"
	end
end