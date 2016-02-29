class PerformanceMeasure < ActiveRecord::Base
  belongs_to :measurable, polymorphic: true

  belongs_to :user

  validates :measurable_id, :measurable_type, :description, :unit_of_measure, :user_id,
            presence: true
end
