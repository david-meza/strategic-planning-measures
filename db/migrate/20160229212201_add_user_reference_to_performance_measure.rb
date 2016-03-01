class AddUserReferenceToPerformanceMeasure < ActiveRecord::Migration
  def change
    add_column :performance_measures, :created_by_user_id, :integer, foreign_key: true, null: false
    add_column :measure_reports, :created_by_user_id, :integer, foreign_key: true, null: false
    add_column :objectives, :created_by_user_id, :integer, foreign_key: true, null: false
    add_column :key_focus_areas, :created_by_user_id, :integer, foreign_key: true, null: false

    add_column :performance_measures, :last_updated_by_user_id, :integer, foreign_key: true
    add_column :measure_reports, :last_updated_by_user_id, :integer, foreign_key: true
    add_column :objectives, :last_updated_by_user_id, :integer, foreign_key: true
    add_column :key_focus_areas, :last_updated_by_user_id, :integer, foreign_key: true

  end
end
