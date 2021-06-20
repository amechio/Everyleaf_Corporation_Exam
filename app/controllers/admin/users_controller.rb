class Admin::UsersController < ApplicationController
  before_action :admin_check
  before_action :set_user, only: [:edit, :update, :destroy]
  def index
    @users = User.all
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end
  def edit
  end
  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'ユーザーを編集しました'
    else
      render :edit
    end
  end
  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザーを削除しました"
  end
  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation ).merge(role: params[:user][:role].to_i)
  end
  def admin_check
    redirect_to tasks_path, notice: '権限がありません' unless current_user.admin?
  end
end
