class Tag < ActiveRecord::Base

  has_many :taggings, dependent: :destroy
  has_many :initiative_planning_guides, through: :taggings
  
end
