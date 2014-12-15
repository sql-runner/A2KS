class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :event_id
      t.string :event_type
      t.belongs_to :user, index: true, null: false
      t.timestamps
    end
  end
end
