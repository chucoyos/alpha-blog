class UsersController < ApplicationController
	before_action :set_user, except: %i[index new create]
	before_action :require_user, only: %i[edit update destroy]
	before_action :require_same_user, only: %i[edit update destroy]

	def index
		@users = User.paginate(page: params[:page], per_page: 5)
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to root_path, notice: "Welcome to the site #{@user.username}"
		else
			render :new
		end
	end

	def show
		@articles = @user.articles.paginate(page: params[:page], per_page: 5)
	end

	def edit; end

	def update
		if @user.update(user_params)
			redirect_to @user, notice: 'Your account was updated successfully'
		else
			render :edit
		end
	end

	def destroy
		@user.destroy
		session[:user_id] = nil if @user == current_user
		redirect_to root_path, notice: 'Account and all associated articles successfully deleted'
	end

	private

	def user_params
		params.require(:user).permit(:username, :email, :password)
	end

	def set_user
		@user = User.find(params[:id])
	end

	def require_same_user
		if current_user != @user && !current_user.admin?
			flash[:alert] = 'You can only edit or delete your own account'
			redirect_to @user
		end
	end
end
