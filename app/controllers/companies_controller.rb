class CompaniesController < ApplicationController
	before_action :authenticate_user
	before_action :validates_company

	def create
		@company = Company.new(company_params)
		if @company.save
			rendirect_to root_path, notice: "Infomración actualizada correctamente"
		else
			erros = @company.errors.full_messages
			redirect_to edit_user_registration_path(@company), :flash => { :error =>  erros}, alert: "No se pudo realizar el registro."
		end
	end

	def update
		redirect_to root_path, notice: "no se ha actuializado"
	end

	

	private

	def company_params
		params.require(:company).permit(:nombre,:direccion,:telefono)
	end

	def set_company
		if Company.exists?(params[:id])
			@company = Company.find(params[:id])
		else
			redirect_to user_index_path, notice: "No se puede actualizar"
		end
	end

	def validates_company
		redirect_to root_path, notice: "No puedes registrarte como compañia, eres un administrador" if @c_user.admin?
	end

end