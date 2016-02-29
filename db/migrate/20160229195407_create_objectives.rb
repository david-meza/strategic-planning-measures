class CreateObjectives < ActiveRecord::Migration
  def change
    create_table :objectives do |t|
      t.references :key_focus_area, index: true, foreign_key: true
      t.string :name, null: false
      t.string :description, null: false, default: ""

      t.timestamps null: false
    end

    add_index :objectives, [:name, :key_focus_area_id], unique: true
  end
end
