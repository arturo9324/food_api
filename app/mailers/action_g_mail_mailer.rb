class ActionGMailMailer < ApplicationMailer
	default from: 'pdao113787@gmail.com'

	def bienvenido_email(user, password)
		@user = user
		@password = password
		mail( to: @user.email, subject: "Bienvenido al sistema de registro de alimentos")
	end
end
