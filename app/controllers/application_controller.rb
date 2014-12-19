class ApplicationController < ActionController::Base
  include Monban::ControllerHelpers
  protect_from_forgery with: :exception
  before_action :place_tags

  def place_tags
    @tags = ActsAsTaggableOn::Tag.all
  end

  def current_user
    super || Guest.new
  end
end
