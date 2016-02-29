class CreatePerformanceMeasures < ActiveRecord::Migration
  def change
    create_table :performance_measures do |t|
      t.references :measurable, polymorphic: true, index: true, null: false
      t.string :description, null: false, default: ""
      t.string :target
      t.string :unit_of_measure, null: false
      t.string :measurement_formula
      t.string :data_source
      t.string :rationale_for_target
      t.string :data_contact_person
      t.string :person_reporting_data_to_bms
      t.string :notes

      t.timestamps null: false
    end

    change_column :objectives, :key_focus_area_id, :integer, null:false
  end
end
