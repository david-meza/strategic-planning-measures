class MeasureReport < ActiveRecord::Base
  belongs_to :performance_measure

  validates :performance_measure_id, :date_start, :date_end, :performance,
            presence: true

  
end
