class UsersController < ApplicationController
	before_action :set_user, except: %i[index new create]

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to root_path, notice: "Welcome to the site #{@user.username}"
		else
			render :new
		end
	end

	def show
		@articles = @user.articles
	end

	def edit; end

	def update
		if @user.update(user_params)
			redirect_to @user, notice: 'Your account was updated successfully'
		else
			render :edit
		end
	end

	private

	def user_params
		params.require(:user).permit(:username, :email, :password)
	end

	def set_user
		@user = User.find(params[:id])
	end
end
