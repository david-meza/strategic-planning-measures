class RemoveNullConstraintsOnUsers < ActiveRecord::Migration
  def change
    change_column :key_focus_areas, :created_by_user_id, :integer, null: true, foreign_key: true, index: true, on_delete: :cascade
    change_column :objectives, :created_by_user_id, :integer, null: true, foreign_key: true, index: true, on_delete: :cascade
    change_column :performance_measures, :created_by_user_id, :integer, null: true, foreign_key: true, index: true, on_delete: :cascade
    change_column :measure_reports, :created_by_user_id, :integer, null: true, foreign_key: true, index: true, on_delete: :cascade
  end
end
