class KeyFocusArea < ActiveRecord::Base

  # ----------------------- Associations --------------------

  has_many :objectives, dependent: :destroy

  has_many :measures, as: :measurable, dependent: :destroy, class_name: "PerformanceMeasure"

  belongs_to :author, foreign_key: :created_by_user_id, class_name: "User"
  
  belongs_to :last_editor, foreign_key: :last_updated_by_user_id, class_name: "User"

  # ----------------------- Logo --------------------
  
  has_attached_file :logo, 
                    styles: { medium: "300x300>", thumb: "100x100>" }, 
                    default_url: "/images/honeycomb.png",
                    storage: :s3,
                    s3_protocol: :https
  
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  # ----------------------- Validations --------------------

  validates :name, :goal, :created_by_user_id,
            presence: true

  validates_uniqueness_of :name
  
  # ----------------------- Methods --------------------


end
