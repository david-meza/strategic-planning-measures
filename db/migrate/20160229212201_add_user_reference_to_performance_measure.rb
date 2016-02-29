class AddUserReferenceToPerformanceMeasure < ActiveRecord::Migration
  def change
    add_column :performance_measures, :user_id, :integer, foreign_key: true, null: false
  end
end
