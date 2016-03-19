class AddExpiredToMeasureReports < ActiveRecord::Migration
  def change
    add_column :measure_reports, :expired, :boolean, null: false, default: false
  end
end
