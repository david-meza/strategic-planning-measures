class InitiativeGoalOutcome < ActiveRecord::Base
  
  belongs_to :initiative_planning_guide


  validates :goal,
            presence: true
end
