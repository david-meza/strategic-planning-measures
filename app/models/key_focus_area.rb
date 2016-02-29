class KeyFocusArea < ActiveRecord::Base

  validates :name, :goal,
            presence: true

  validates_uniqueness_of :name
end
