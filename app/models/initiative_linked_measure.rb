class InitiativeLinkedMeasure < ActiveRecord::Base
  
  belongs_to :initiative_planning_guide
  belongs_to :performance_measure
  
end
