class CreateInitiativeLinkedMeasures < ActiveRecord::Migration
  def change
    create_table :initiative_linked_measures do |t|
      t.belongs_to :initiative_planning_guide, index: true, foreign_key: true
      t.belongs_to :performance_measure, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
