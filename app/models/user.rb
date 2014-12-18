class User < ActiveRecord::Base
  include Actionable
  has_many :videos
  has_many :likes
  has_many :liked_videos, through: :likes, source: :video

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  def add_like_to_video(video)
    liked_videos.append video
  end

  def delete_like_from_video(video)
    liked_videos.delete video
  end

  def to_param
    username
  end
end
