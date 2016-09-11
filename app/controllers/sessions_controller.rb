class SessionsController < ApplicationController
  def new
  end
  def create
  	@user = User.find_by(email: params[:session][:email].downcase)
  	if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
    		login @user
        params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
    		flash[:success] = "欢迎 back"
    		redirect_back_or @user
      else
        flash[:warning] = "Check your email for the activation link."
        redirect_to root_url
      end
  	else
  		flash.now[:warning] = "Invalid Email/Password combination."
  		render :new
  	end
  end
  def destroy
  	logout if logged_in?
  	redirect_to root_url
  end
end
