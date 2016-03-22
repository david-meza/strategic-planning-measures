class PerformanceFactorEntry < ActiveRecord::Base
  belongs_to :performance_factor
  belongs_to :measure_report
end
