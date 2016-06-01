class CreateInitiativePlanningGuides < ActiveRecord::Migration
  def change
    create_table :initiative_planning_guides do |t|
      
      t.references :objective, index: true, foreign_key: true
      t.string :description, null: false
      t.string :initiative_stage
      t.string :project_commitment
      t.text :initiative_overview
      t.text :major_milestones

      t.integer :created_by_user_id, foreign_key: true
      t.integer :last_updated_by_user_id, foreign_key: true

      t.timestamps null: false
    end
  end
end
