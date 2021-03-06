class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]
  def index
    @users = User.where(activated: true).paginate(page: params[:page], per_page: 10)
  end
  def new
  	@user = User.new
  end
  def create
  	@user = User.new(user_params)
  	if @user.save
      @user.send_activation_email
  		flash[:info] = "#{@user.id} 请去 #{@user.email} 激活你的账户"
  		redirect_to root_url
  	else
  		render :new
  	end
  end
  def show
  	@user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
  end
  def edit
  end
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Update Profile success"
      redirect_to edit_user_url(@user)
    else
      render :edit
    end
  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end
    def logged_in_user
      unless logged_in?
        store_location
        flash[:warning] = "Please login before your move"
        redirect_to login_url
      end
    end
    def correct_user
      @user = User.find(params[:id])
      if @user != current_user
        flash[:warning] = "Please dont touch other's info"
        redirect_to root_url
      end
    end
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end
