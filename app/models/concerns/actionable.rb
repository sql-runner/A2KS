module Actionable
  extend ActiveSupport::Concern

  included do
    has_many(
      :activities,
      as: :event,
      dependent: :destroy
    )
  end
end
