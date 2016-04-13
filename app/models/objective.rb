class Objective < ActiveRecord::Base

  # ----------------------- Associations --------------------

  belongs_to :key_focus_area

  has_many  :measures, 
            as: :measurable, 
            dependent: :destroy, 
            class_name: 'PerformanceMeasure'

  include UserRules
 
  # ----------------------- Callbacks --------------------
  
  before_create :author_is_admin
  before_update :editor_is_admin

  # ----------------------- Validations --------------------

  validates :key_focus_area_id, :name, :description,
            presence: true

  validates_uniqueness_of :name, 
                          scope: :key_focus_area_id,
                          case_sensitive: false,
                          message: "duplicate objective in this Key Focus Area"



end
