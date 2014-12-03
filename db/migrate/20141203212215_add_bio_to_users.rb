class AddBioToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bio_content, :text
  end
end
