class KeyFocusArea < ActiveRecord::Base

  # ----------------------- Associations --------------------

  has_many :objectives, dependent: :destroy

  has_many :performance_measures, as: :measurable, dependent: :destroy

  belongs_to :author, foreign_key: :created_by_user_id, class_name: "User"
  
  belongs_to :last_editor, foreign_key: :last_updated_by_user_id, class_name: "User"

  # ----------------------- Validations --------------------

  validates :name, :goal, :created_by_user_id,
            presence: true

  validates_uniqueness_of :name
end
