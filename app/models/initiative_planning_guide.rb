class InitiativePlanningGuide < ActiveRecord::Base
  
  belongs_to :objective

  has_many :initiative_plan_years
  has_many :initiative_humans

  include UserRules

  accepts_nested_attributes_for :initiative_plan_years,
                                # allow_destroy: true,
                                reject_if: proc { |attributes| attributes['year'].blank? }

  # ----------------------- Callbacks --------------------
  
  before_create :author_is_admin
  before_update :editor_is_admin


  # ----------------------- Validations --------------------

  validates :objective_id, :description,
            presence: true
  
  # ----------------------- Virtual attributes --------------------
  
  def parents
    [objective.key_focus_area, objective]
  end

  def key_focus_area
    objective.key_focus_area
  end

  # ----------------------- Class methods --------------------
  
  def self.filter_results(query, current_user)
    return where( data_contact_person_email: current_user.try(:email) ) if query[:filter_data_contact]
    all
  end

  # ----------------------- Instance methods --------------------
  

end
