class VideosController < ApplicationController
  def new
    @user = User.find_by(username: params[:user_id])
    @video = Video.new
  end

  def create
    user = User.find_by(username: params[:user_id])
    the_video = user.videos.new(find_video_params)

    if the_video.save
      redirect_to user_path(user)
    else
      render :new
    end
  end

  def show
    @video = Video.find(params[:id])
  end

  private

  def find_video_params
    params.require(:video).permit(
      :description,
      :media,
      :name
    )
  end
end
