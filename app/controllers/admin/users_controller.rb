class Admin::UsersController < ApplicationController
  before_action :non_admin
  helper_method :sort_column, :sort_direction
  
  def index
    @users = User.all.order("#{sort_column} #{sort_direction}")
    @users = @users.page params[:page]
  end

  def show
    @user = User.find(params[:id])
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

  private

  def non_admin
    redirect_to new_session_path unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin)
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end
end
