class VideosController < ApplicationController
  before_action :require_login

  def new
    @video = Video.new
  end

  def create
    VideoUpdater.new(current_user).create(find_video_params)
    redirect_to dashboard_path
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
