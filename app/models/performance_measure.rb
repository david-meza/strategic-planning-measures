class PerformanceMeasure < ActiveRecord::Base

  # ----------------------- Associations --------------------

  belongs_to :measurable, polymorphic: true

  has_many :measure_reports, dependent: :destroy

  belongs_to :author, foreign_key: :created_by_user_id, class_name: "User"
  
  belongs_to :last_editor, foreign_key: :last_updated_by_user_id, class_name: "User"


  # ----------------------- Validations --------------------

  validates :measurable_id, :measurable_type, :description, :unit_of_measure, :created_by_user_id,
            presence: true
end
