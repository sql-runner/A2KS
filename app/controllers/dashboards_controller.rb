class DashboardsController < ApplicationController
  def index
  end

  def show
    @activities = current_user.recent_activities(5)
  end
end
