class CreateInitiativeHumans < ActiveRecord::Migration
  def change
    create_table :initiative_humans do |t|
      t.references :initiative_planning_guide, index: true, foreign_key: true
      t.string :name, null: false
      t.string :department
      t.string :email
      t.string :category, null: false

      t.timestamps null: false
    end
  end
end
