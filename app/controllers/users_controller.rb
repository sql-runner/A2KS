class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :check_sign_in, only: [:show, :update]

  def new
    @user = User.new
  end

  def show
    @user = User.find_by(username: params[:id])
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
    the_user = User.find_by(username: params[:id])
    @user = the_user.update(user_params)
    redirect_to :back
  end

  private

  def check_sign_in
    unless signed_in?
      redirect_to new_session_path
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :username, :avatar)
  end
end

