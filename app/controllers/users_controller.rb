class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  
  def new
    @user = User.new
    redirect_to tasks_path if current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "ユーザー登録しました"
      redirect_to user_path(@user.id)
    else
      flash.now[:danger] = "ユーザー登録に失敗しました"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    redirect_to tasks_path unless current_user.id == @user.id
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
