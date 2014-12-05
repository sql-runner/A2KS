class AddMediaColumnToVideos < ActiveRecord::Migration
  def self.up
    add_attachment :videos, :media
  end

  def self.down
    remove_attachment :videos, :media
  end
end
