class Video < ActiveRecord::Base
  include Actionable
  belongs_to :user
  has_many :likes
  acts_as_taggable

  has_attached_file(
    :media,
    path: "/:class/:id/:style/:filename",
    styles:{
      medium: { format: "mp4", streaming: true,
        convert_options: {
          output: { strict: "experimental", s: "320x240" }}},
      original: { format: "mp4", streaming: true,
        convert_options: {
          output: { strict: "experimental", s: "640x480" }}},
      thumb: { format: "jpg",
        convert_options: {
          output: { strict: "experimental", ss: 1, vframes: 1, s: "120x90" }}}
    },
    processors: [:transcoder],
    use_timestamp: false
  )
  do_not_validate_attachment_file_type :media

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  def self.search_results(params)
    where("description ILIKE ?", "%#{params}%")
  end
end
