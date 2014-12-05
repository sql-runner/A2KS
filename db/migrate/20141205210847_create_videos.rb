class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.references :user, index: true
      t.text :description
      t.string :name

      t.timestamps
    end
  end
end
