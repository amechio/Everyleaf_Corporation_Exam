class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :to_user_profile, only: [:new, :create]
  before_action :return_my_page, only: [:index, :edit, :update, :show]
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end
  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  def to_user_profile
    redirect_to tasks_path, notice: "ログインしてます" if current_user
  end
  def return_my_page
    if logged_in?
      unless current_user.id == params[:id].to_i || current_user.role == 'admin'
        flash[:notice] = '権限がありません'
        redirect_to tasks_path
      end
    else
      redirect_to new_user_path, notice: 'ログインが必要です'
    end
  end
end
