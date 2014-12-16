class Activity < ActiveRecord::Base
  belongs_to :event, polymorphic: true
  belongs_to :user
end
