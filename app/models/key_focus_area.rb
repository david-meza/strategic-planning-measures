class KeyFocusArea < ActiveRecord::Base

  # ----------------------- Associations --------------------

  has_many  :objectives, 
            dependent: :destroy

  has_many  :measures, 
            as: :measurable, 
            dependent: :destroy, 
            class_name: "PerformanceMeasure"

  include UserRules

  # ----------------------- Callbacks --------------------
  
  before_create :author_is_admin
  before_update :editor_is_admin

  # ----------------------- Logo --------------------
  
  has_attached_file :logo, 
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: "/images/honeycomb.png",
                    storage: :s3,
                    s3_protocol: :https
  
  validates_attachment_content_type :logo, 
                                    content_type: /\Aimage\/.*\Z/
  
  validates_attachment_size :logo, 
                            less_than: 2.megabytes

  # ----------------------- Validations --------------------

  validates :name, :goal,
            presence: true

  validates_associated :author

  validates_uniqueness_of :name,
                          message: "duplicate key focus area with this name",
                          case_sensitive: false
  
  # ----------------------- Methods --------------------


end
