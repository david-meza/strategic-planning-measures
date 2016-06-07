class CreateInitiativeGoalOutcomes < ActiveRecord::Migration
  def change
    create_table :initiative_goal_outcomes do |t|
      t.belongs_to :initiative_planning_guide, null: false, index: true, foreign_key: true
      t.string :goal, null: false
      t.text :outcome

      t.timestamps null: false
    end
  end
end
