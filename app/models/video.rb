class Video < ActiveRecord::Base
  has_attached_file :media,
    path: "/:class/:id/:filename",
#    styles: {
#      medium: { geometry: "640x480", format: "flv",
#                convert_options: {output: {ar: 44100}}
#    },
#      large: { geometry: "1024x576", format: "flv",
#               convert_options: {output: {ar: 44100}}
#      }
#    },
    processors: [:transcoder],
    use_timestamp: false

  do_not_validate_attachment_file_type :media
  belongs_to :user

  WEB_MP4_PRESET_ID="1351620000001-000020"
  AWS_PIPELINE_ID="1418138948317-hgb52z"

  def original_file_path
    s3_file_name = media.url.gsub(/.*\/\/.*\/\d+\//, "")
    s3_path_name = "videos/#{id}/#{s3_file_name}"
    s3_path_name
  end

  def elastic_transcode
    the_s3_path = original_file_path
    transcoder = AWS::ElasticTranscoder::Client.new(
      access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
    )
    transcoder.create_job(
      pipeline_id: AWS_PIPELINE_ID,
      input: {
        key: the_s3_path,
        frame_rate: 'auto',
        resolution: 'auto',
        aspect_ratio: 'auto',
        interlaced: 'auto',
        container: 'auto'
      },
      output: {
        key: the_s3_path + ".mp4",
        preset_id: WEB_MP4_PRESET_ID,
        thumbnail_pattern: "",
        rotate: '0'
      }
    )
  end
end
