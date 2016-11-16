class UsersController < Devise::RegistrationsController

	#before_action :authenticate_admin!, only: [:index, :new, :create, :destroy]
	skip_before_action :require_no_authentication
	before_action :authenticate_user
	before_action :authenticate_admin!, except: [:edit, :update]
	before_action :set_user, only: [:destroy]
	before_action :be_owner, only: [:destroy]
	before_action :set_company, only: [:edit]
	def index
		@user = User.paginate(page: params[:page], per_page: 10).all.admin
	end

	def new
		#raise params.to_yaml
		@user = User.new
	end

	def create
		#raise params.to_yaml
		@contraseña_correo = params[:user][:password]
		@user = User.new(create_user_params)
		if @user.save
			if params[:user][:admin]
				@user.be_admin
			end
			ActionGMailMailer.bienvenido_email(@user,@contraseña_correo).deliver
			redirect_to root_path, notice: "Se ha creado el usuario"
		else
			render :new
		end
	end

	def edit
		super
	end

	def update
		super
	end

	def destroy
		@d_user.destroy
		redirect_to user_index_path, notice: "Se ha eliminado correctamente"
	end

	def cancel
		redirect_to root_path
	end
	
	private 

	def set_company
		company = User.find(@c_user.id).company
		if  @comapany.nil?
			if company.nil?
				@company = Company.new
			else
				@company = company
			end
		end
	end

	def authenticate_admin!
		redirect_to root_path, alert: "Solo administradores" unless @c_user.admin
	end

	def create_user_params
		params.require(:user).permit(:email,:password, :password_confirmation)
	end

	def set_user
		@d_user = User.find_by_id(params[:id_user])
		if @d_user.nil?
			redirect_to user_index_path, alert: "El usuario no existe"
		end
	end

	def be_owner
		if @d_user.id == current_user.id
			redirect_to user_index_path, alert: "Tu cuenta no puede ser eliminada"
		end
	end

	
end