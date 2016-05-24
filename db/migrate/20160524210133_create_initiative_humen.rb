class CreateInitiativeHumen < ActiveRecord::Migration
  def change
    create_table :initiative_humen do |t|
      t.references :initiative_planning_guide, index: true, foreign_key: true
      t.string :name, null: false
      t.string :email, null: false
      t.string :category, null: false

      t.timestamps null: false
    end
  end
end
