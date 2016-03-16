class AddBmsCommentsToMeasureReports < ActiveRecord::Migration
  def change
    add_column :measure_reports, :bms_comments, :string
  end
end
