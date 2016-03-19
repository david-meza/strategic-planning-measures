class PerformanceMeasure < ActiveRecord::Base

  # ----------------------- Associations --------------------

  belongs_to :measurable, polymorphic: true

  belongs_to :key_focus_area, -> { where(performance_measures: {measurable_type: 'KeyFocusArea'}) }, foreign_key: 'measurable_id'

  has_many :measure_reports, dependent: :destroy

  belongs_to :author, foreign_key: :created_by_user_id, class_name: "User"
  
  belongs_to :last_editor, foreign_key: :last_updated_by_user_id, class_name: "User"


  # ----------------------- Validations --------------------

  validates :measurable_id, :measurable_type, :description, :unit_of_measure, :created_by_user_id,
            presence: true
  
  # ----------------------- Virtual attributes --------------------

  def kfa_name
    meas = self.measurable
    return meas.name if self.measurable_type == "KeyFocusArea"
    meas.key_focus_area.name
  end

  def parents
    meas = self.measurable
    return [meas] if self.measurable_type == "KeyFocusArea"
    [meas.key_focus_area, meas]
  end

end
