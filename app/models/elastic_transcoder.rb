class ElasticTranscoder
  attr_accessor :video
  def initialize(video)
    @video = video
  end

  WEB_MP4_PRESET_ID = "1351620000001-000030"
  AWS_PIPELINE_ID = "1418138948317-hgb52z"

  def transcode!
    transcoder = amazon_web_client
    transcoder.create_job(
      pipeline_id: AWS_PIPELINE_ID,
      input: {
        key: original_file_path,
        frame_rate: "auto",
        resolution: "auto",
        aspect_ratio: "auto",
        interlaced: "auto",
        container: "auto"
      },
      output: {
        key: original_file_path + ".mp4",
        preset_id: WEB_MP4_PRESET_ID,
        thumbnail_pattern: "",
        rotate: "auto"
      }
    )
  end

  def original_file_path
    s3_file_name = video.media.url.gsub(/.*\/\/.*\/\d+\//, "")
    s3_path_name = "videos/#{video.id}/#{s3_file_name}"
    s3_path_name
  end

  def amazon_web_client
    AWS::ElasticTranscoder::Client.new(
      access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
    )
  end
end
