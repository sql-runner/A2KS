class ElasticTranscoder
  attr_accessor :video
  attr_reader :web_client

  def initialize(video)
    @video = video
    @web_client = create_web_client
  end

  def transcode!
    web_client.create_job(
      pipeline_id: ENV["AWS_PIPELINE_ID"],
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
        preset_id: ENV["WEB_MP4_PRESET_ID"],
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

  def create_web_client
    AWS::ElasticTranscoder::Client.new(
      access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
    )
  end
end
