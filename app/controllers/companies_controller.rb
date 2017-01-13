class CompaniesController < ApplicationController
	before_action :authenticate_user
	before_action :validates_company
	before_action :set_company, only: [:edit, :update]

	def new
		if @c_user.company.nil?
			@company = Company.new
		else
			@company = @c_user.company
		end
	end

	def edit
	end

	def create
		@company = @c_user.build_company(company_params)
		if @company.save
			rendirect_to root_path, notice: "Infomración actualizada correctamente"
		else
			render :new
		end
	end

	def update
		redirect_to root_path, notice: "no se ha actuializado"
	end

	

	private

	def company_params
		params.fetch(:company, {}).permit(:nombre,:direccion,:telefono)
	end

	def set_company
		if Company.exists?(params[:id])
			@company = Company.find(params[:id])
			unless @c_user.company == @company
				redirect_to root_path, alert: "No tienes permiso de acceder a esta página"
			end
		else
			@company = Company.new
			render :new
		end
	end

	def validates_company
		redirect_to root_path, notice: "No puedes registrarte como compañia, eres un administrador" if @c_user.admin?
	end

end