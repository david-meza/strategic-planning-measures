class CreatePerformanceFactors < ActiveRecord::Migration
  def change
    create_table :performance_factors do |t|
      t.references :performance_measure, index: true, foreign_key: true, null: false
      t.string :label_text, null: false
      t.string :field_type, null: false

      t.timestamps null: false
    end
  end
end
