class Tagging < ActiveRecord::Base
  belongs_to :initiative_planning_guide
  belongs_to :tag
end
