class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.belongs_to :initiative_planning_guide, index: true, foreign_key: true, null: false
      t.belongs_to :tag, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
