class SessionsController < ApplicationController
  def new
  end
  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		login user
  		flash[:success] = "欢迎 back"
  		redirect_to user
  	else
  		flash.now[:warning] = "Invalid Email/Password combination."
  		render :new
  	end
  end
  def destroy
  	logout
  	redirect_to root_url
  end
end
