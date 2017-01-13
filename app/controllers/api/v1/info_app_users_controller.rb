class Api::V1::InfoAppUsersController < Api::V1::MasterApiController 
	before_action :authenticate_user
	before_action :set_disease_params

	def index
		@info_app_user = @app_user.info_app_user
		if not @info_app_user.nil?
			if @info_app_user.has_diseases.nil?
				render "api/v1/info_app_users/show"
				return
			else
				render "api/v1/info_app_users/show_disease"
				return
			end
		else
			error!("Aun no has registrado esa información", :not_found)
			return
		end

	end

	def create
		if @app_user.info_app_user.nil?
			@info_app_user = @app_user.build_info_app_user(info_params)
			if @info_app_user.save
				if @diseases.empty?
					render "api/v1/info_app_users/show"
					return
				else
					if exist_disease
						if save_diseses
							render "api/v1/info_app_users/show_disease"
							return
						else
							@errors << "No se pudieron registrar las enferemdades seleccionadas"
							render "api/v1/info_app_users/show", status: :partial_content
							return
						end
					else
						@errors << "No se pudieron registrar las enferemdades seleccionadas"
						render "api/v1/info_app_users/show", status: :partial_content
						return
					end
				end
			else
				error_array!(@info_app_user.errors.full_messages,:unprocessable_entity)
				return
			end
		else
			@params = info_params
			update
		end
	end

	def update
		@info_app_user = @app_user.info_app_user
		if @info_app_user.update(@params)
			if @diseases.empty?
				delete_diseases!
				render "api/v1/info_app_users/show"
				return
			else
				if has_diseases
					render "api/v1/info_app_users/show_disease"
					return
				else
					if exist_disease
						delete_diseases!
						if save_diseses
							render "api/v1/info_app_users/show_disease"
							return
						else
							@errors << "No se pudieron registrar las enferemdades seleccionadas"
							render "api/v1/info_app_users/show", status: :partial_content
							return
						end
					else
						if not @info_app_user.has_diseases.any?
							@errors << "No se pudieron registrar las enferemdades seleccionadas"
							render "api/v1/info_app_users/show", status: :partial_content
							return
						else
							@errors << "No se pudieron registrar las enferemdades seleccionadas"
							render "api/v1/info_app_users/show_disease", status: :partial_content
							return
						end
					end

				end
			end
		else
			error_array!(@info_app_user.errors.full_messages, :unprocessable_entity)
			return
		end
	end

	private

	def save_diseses
		records =[]
		@rec.each do |d|
			@info_app_user.has_diseases.create(disease: d)
		end
		success = @rec.each(&:save)
		if success.any?
			return true
		end
		return false
	end

	def has_diseases
		@diseases.each do |d|
			dis = HasDisease.find_by(disease: Disease.find_by(id: d), info_app_user: @info)
			if dis.nil?
				return false
			end
		end
		return true
	end

	def info_params
		params.fetch(:info, {}).permit(:fecha_nacimiento, :peso, :estatura, :sexo, :max_calorias, :min_calorias, :embarazo, :lactancia)
	end

	def set_disease_params
		@diseases = []
		if params.has_key?(:diseases)
			@diseases = params[:diseases]
			@diseases = @diseases.uniq
		end
	end

	def exist_disease
		@rec = []
		@diseases.each do |d|
			dis = Disease.find_by(id: d)
			if dis.nil?
				return false
			end
			@rec << dis
		end 
		return true
	end

	def delete_diseases!
		dis = HasDisease.where(info_app_user: @info_app_user)
		unless dis.empty?
			dis.each(&:destroy)
		end
	end

end