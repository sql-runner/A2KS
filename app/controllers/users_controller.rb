class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :require_login, only: [:show, :update]

  def new
    @user = User.new
  end

  def show
    @user = find_user
  end

  def create
    @user = sign_up(user_params)

    if @user.valid?
      sign_in(@user)
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def update
    UserUpdater.new(current_user).update(user_params)
    redirect_to :back
  end

  private

  def find_user
    User.find_by(username: params[:id])
  end

  def user_params
    params.require(:user).permit(
      :avatar,
      :bio_content,
      :email,
      :password,
      :username
    )
  end
end

