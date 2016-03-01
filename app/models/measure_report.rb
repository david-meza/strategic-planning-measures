class MeasureReport < ActiveRecord::Base

  # ----------------------- Associations --------------------

  belongs_to :performance_measure

  belongs_to :author, foreign_key: :created_by_user_id, class_name: "User"
  
  belongs_to :last_editor, foreign_key: :last_updated_by_user_id, class_name: "User"

  # ----------------------- Validations --------------------

  validates :performance_measure_id, :date_start, :date_end, :performance, :created_by_user_id,
            presence: true

  
end
