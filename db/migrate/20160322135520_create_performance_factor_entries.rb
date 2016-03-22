class CreatePerformanceFactorEntries < ActiveRecord::Migration
  def change
    create_table :performance_factor_entries do |t|
      t.references :performance_factor, index: true, foreign_key: true, null: false
      t.references :measure_report, index: true, foreign_key: true, null: false
      t.string :data, null: false
      t.text :comments

      t.timestamps null: false
    end
  end
end
