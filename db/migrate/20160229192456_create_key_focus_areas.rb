class CreateKeyFocusAreas < ActiveRecord::Migration
  def change
    create_table :key_focus_areas do |t|
      t.string :name, null: false
      t.string :goal, null: false, default: ""

      t.timestamps null: false
    end

    add_index :key_focus_areas, :name, unique: true
    
  end
end
