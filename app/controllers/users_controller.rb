class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = sign_up(user_params)

    if @user.valid?
      sign_in(@user)
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def update
    the_user = User.find(params[:id])
    @user = the_user.update(user_params)
    redirect_to :back
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :avatar)
  end
end

