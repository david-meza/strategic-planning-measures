class AddFrequencyDataAvailableToPerformanceMeasures < ActiveRecord::Migration
  def change
    add_column :performance_measures, :frequency_data_available, :string
    change_column :measure_reports, :performance, :string, null: true
  end
end
