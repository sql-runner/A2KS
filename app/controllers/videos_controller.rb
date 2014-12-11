class VideosController < ApplicationController
  before_action :require_login
  before_action :allow_user, only: [:new, :create]

  def new
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

  def allow_user
    unless current_user == find_user_owner
      render "public/404.html"
    end
  end

  def find_user_owner
    @user = User.find_by(username: params[:user_id])
  end

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
