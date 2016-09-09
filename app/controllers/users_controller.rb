class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index]
  before_action :correct_user, only: [:edit, :update]
  def index
    @users = User.all
  end
  def new
  	@user = User.new
  end
  def create
  	@user = User.new(user_params)
  	if @user.save
      login @user
  		flash[:success] = "第 #{@user.id} 号山里人，欢迎你！"
  		redirect_to @user
  	else
  		render :new
  	end
  end
  def show
  	@user = User.find(params[:id])
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
end
