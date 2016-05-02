class PerformanceFactor < ActiveRecord::Base

  # ----------------------- Associations --------------------
 
  belongs_to :performance_measure

  has_many  :performance_factor_entries, 
            dependent: :destroy
  
  has_many  :measure_reports, 
            through: :performance_factor_entries

  # ----------------------- Validations --------------------

  validates :label_text, :field_type,
            presence: true
end
