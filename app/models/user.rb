class User < ActiveRecord::Base
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  has_many :activities
  has_many :videos

  def recent_activities(amount)
    activities.order("created_at DESC").limit(amount)
  end

  def to_param
    username
  end
end
