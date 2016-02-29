class Objective < ActiveRecord::Base
  belongs_to :key_focus_area

  validates :key_focus_area_id, :name, :description,
            presence: true

  validates_uniqueness_of :name, scope: :key_focus_area_id

end
