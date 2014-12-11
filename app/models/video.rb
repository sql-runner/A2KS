class Video < ActiveRecord::Base
  has_attached_file(
    :media, path: "/:class/:id/:filename",
    processors: [:transcoder],
    use_timestamp: false
  )
  do_not_validate_attachment_file_type :media
  validates :name, presence: true
  validates :description, presence: true
  belongs_to :user

end
