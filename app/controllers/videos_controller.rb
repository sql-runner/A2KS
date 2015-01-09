class VideosController < ApplicationController
  before_action :require_login, only: [:new, :create]
  before_action :check_sign_in, only: [:show]

  def new
    @video = Video.new
    @tags = ActsAsTaggableOn::Tag.all
  end

  def create
    @video_updater = VideoUpdater.new(current_user)

    if @video_updater.create(find_video_params)
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def show
    @video = find_video
  end

  private

  def check_sign_in
    unless signed_in?
      redirect_to new_session_path
    end
  end

  def find_video
    Video.find(params[:id])
  end

  def find_video_params
    params.require(:video).permit(
      :description,
      :media,
      :name,
      :tag_list
    )
  end
end
