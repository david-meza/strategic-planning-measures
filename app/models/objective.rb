class Objective < ActiveRecord::Base

  # ----------------------- Associations --------------------

  belongs_to :key_focus_area

  has_many :measures, as: :measurable, dependent: :destroy, class_name: 'PerformanceMeasure'

  belongs_to :author, foreign_key: :created_by_user_id, class_name: "User"
  
  belongs_to :last_editor, foreign_key: :last_updated_by_user_id, class_name: "User"

  # ----------------------- Validations --------------------

  validates :key_focus_area_id, :name, :description, :created_by_user_id,
            presence: true

  validates_uniqueness_of :name, scope: :key_focus_area_id

end
