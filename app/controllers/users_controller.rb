class UsersController < Devise::RegistrationsController

	#before_action :authenticate_admin!, only: [:index, :new, :create, :destroy]
	skip_before_action :require_no_authentication
	before_action :authenticate_user
	before_action :authenticate_admin!, except: [:edit, :update]
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
		redirect_to root_path, notice: "se ha enviado a eliminar pero no se ha eliminado"
	end

	def cancel
		redirect_to root_path
	end
	
	private 

	def authenticate_user
		redirect_to(new_user_session_path, alert: "Tienes que iniciar sesión") unless user_signed_in?
	end

	def authenticate_admin!
		redirect_to root_path, alert: "Solo administradores" unless current_user.admin
	end

	def create_user_params
		params.require(:user).permit(:email,:password, :password_confirmation)
	end

	
end