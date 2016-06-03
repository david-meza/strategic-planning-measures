class CreateInitiativePlanYears < ActiveRecord::Migration
  def change
    create_table :initiative_plan_years do |t|
      t.references :initiative_planning_guide, index: true, foreign_key: true
      t.integer :year, null: false
      t.boolean :expired
      t.date :date_expired
      t.timestamps null: false
    end
  end
end
