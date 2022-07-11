class Admin::UsersController < ApplicationController
  before_action :non_admin
  helper_method :sort_column, :sort_direction
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザー登録しました"
      redirect_to admin_users_path(@user.id)
    else
      flash.now[:danger] = "ユーザー登録に失敗しました"
      render :new
    end
  end

  def index
    @users = User.all.order("#{sort_column} #{sort_direction}")
    @users = @users.page params[:page]
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.all.page params[:page]
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path, notice: "ユーザー情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_path, notice: "ユーザーを削除しました"
    else
      redirect_to admin_users_path, notice: "#{@user.errors[:base]}"
    end
  end

  private

  def non_admin
    redirect_to tasks_path, notice: "管理者以外はアクセスできません" unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end
end
