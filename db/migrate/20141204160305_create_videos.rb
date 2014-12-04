class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.references :user, index: true
      t.text :description, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
