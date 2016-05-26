class CreateInitiativeHumans < ActiveRecord::Migration
  def change
    create_table :initiative_humans do |t|
      t.references :initiative_planning_guide, index: true, foreign_key: true
      t.string :name
      t.string :email
      t.string :category

      t.timestamps null: false
    end
  end
end
