class SessionsController < ApplicationController

	def index
		@user = User.new
	end

	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			flash[:notice] = "You have successfully logged in #{user.username}"
			session[:user_id] = user.id

			#sign_in user
			redirect_to user
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = 'You have successfully logged out'
		redirect_to root_url
	end
end
