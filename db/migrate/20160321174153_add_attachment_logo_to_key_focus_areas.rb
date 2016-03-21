class AddAttachmentLogoToKeyFocusAreas < ActiveRecord::Migration
  def self.up
    change_table :key_focus_areas do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :key_focus_areas, :logo
  end
end
