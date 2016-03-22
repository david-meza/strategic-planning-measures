class PerformanceFactorEntry < ActiveRecord::Base
  
  # ----------------------- Associations --------------------

  belongs_to :performance_factor
  belongs_to :measure_report

  # ----------------------- Validations --------------------

  validates :data,
            presence: true
end
