class DashboardsController < ApplicationController
  def index
    @video = Video.find_by(id: 1)
  end

  def show
    @activities = Activity.all.where(user_id: current_user).
                    order("created_at DESC").limit(7)
  end
end
