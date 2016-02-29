class CreateMeasureReports < ActiveRecord::Migration
  def change
    create_table :measure_reports do |t|
      t.references :performance_measure, index: true, foreign_key: true, null: false
      t.date :date_start, null: false
      t.date :date_end, null: false
      t.string :performance, null: false
      t.string :status
      t.string :comments

      t.timestamps null: false
    end
  end
end
