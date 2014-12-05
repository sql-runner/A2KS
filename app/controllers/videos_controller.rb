class VideosController < ApplicationController
  def new
    @user = User.find_by(username: params[:user_id])
    @video = Video.new
  end

  def create
    user = User.find_by(username: params[:user_id])
    video = user.videos.new(find_video_params)

    if video.save
      ElasticTranscoder.new(video).transcode!
      redirect_to user_path(user)
    else
      render :new
    end
  end

  def show
    @video = find_video
  end

  private

  def find_video
    Video.find(params[:id])
  end

  def find_video_params
    params.require(:video).permit(
      :description,
      :media,
      :name
    )
  end
end
