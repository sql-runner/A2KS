class Video < ActiveRecord::Base
  has_attached_file :media,
    styles: {
      medium: { geometry: "640x480", format: "flv",
                convert_options: {output: {ar: 44100}}
      },
      large: { geometry: "1024x576", format: "flv",
               convert_options: {output: {ar: 44100}}
      }
    },
    processors: [:transcoder],
    use_timestamp: false

  do_not_validate_attachment_file_type :media
  belongs_to :user
end
