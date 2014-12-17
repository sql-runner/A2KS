class VideoUpdater
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def create(params)
    @video = user.videos.new(params)

    if @video.save
      update_activities
    else
      false
    end
  end

  private

  def update_activities
    create_video
  end

  def create_video
    Activity.create(
      event: @video,
      title: "Video Created",
      user: user
    )
  end
end
