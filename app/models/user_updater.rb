class UserUpdater
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def update(params)
    user.attributes = params
    if user.valid?
      update_activities
      user.save
    end
  end

  private

  def update_activities
    update_avatar
    update_bio
  end

  def update_avatar
    if user.avatar_updated_at_changed?
      Activity.create(
       event: user,
       title: "Avatar Updated!",
       user: user
      )
    end
  end

  def update_bio
    if user.bio_content_changed?
      Activity.create(
        event: user,
        title: "Bio Updated!",
        user: user
      )
    end
  end
end
