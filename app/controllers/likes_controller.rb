class LikesController < ApplicationController
  before_action :require_login

  def create
    current_user.add_like_to_video(find_video)
    redirect_to :back
  end

  def destroy
    current_user.delete_like_from_video(find_video)
    redirect_to :back
  end

  private

  def find_video
    Video.find(params[:video_id])
  end
end
