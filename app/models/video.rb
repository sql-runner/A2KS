class Video < ActiveRecord::Base
  include Actionable
  belongs_to :user
  has_many :likes
  acts_as_taggable

  has_attached_file(
    :media,
    path: "/:class/:id/:filename",
    processors: [:transcoder],
    use_timestamp: false
  )
  do_not_validate_attachment_file_type :media

  validates :name, presence: true
  validates :description, presence: true

  def self.search_results(params)
    where("description ILIKE ?", "%#{params}%")
  end
end
