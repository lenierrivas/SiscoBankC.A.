class UsersController < ApplicationController
	def index
		## params :query filtra los elementos por busqueda ingresada
		## pagy para la paginacion next previus
			if params[:query].present?
				@pagy, @users = pagy(User.where("name like ?", "%#{params[:query]}%").order('id ASC'), items: 5)
			else
				@pagy, @users = pagy(User.all.order('id ASC'), items: 5)
			end
	end

	def show
		user
	end

	def new
		@user = User.new(request_params)
	end

	def create
		## guardamos, redireccionamos y mandamos notificación
			@user = User.new(request_params)

			if @user.save
				redirect_to users_path, 
					notice: t('notice.user_regist')
			else
				render :new, 
					status: :unprocessable_entity
			end	
	end

	def edit
		user 
	end

	def update
		## actualizamos, redireccionamos y mandamos notificación. En caso contrario mandamos error para mostrar las validaciones
			if user.update( request_params )
				redirect_to users_path, 
					notice: t('notice.user_update')
			else
				render :edit, 
					status: :unprocessable_entity
			end
	end

	def destroy
		## eliminamos, redireccionamos y mandamos notificación.
			user.destroy
			redirect_to users_path, 
				notice: t('notice.user_delet'), 
				status: :see_other
	end

	private
		def user
			## refactorizamos para reutilizar codigo
				@user = User.find( params[ :id ] )
		end

		def request_params
			## establecemos los parametros permitidos en los requests
				params.require( :user ).permit( 
					:account_type, 
					:type_person, 
					:identification, 
					:name, 
					:email, 
					:tlf, 
					:tlf_second, 
					:emit, 
					:expiration 
				) rescue{}
		end
end