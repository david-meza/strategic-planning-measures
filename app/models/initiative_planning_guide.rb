class InitiativePlanningGuide < ActiveRecord::Base
  
  belongs_to :objective

  include UserRules

  # accepts_nested_attributes_for :performance_factors,
  #                               reject_if: :all_blank,
  #                               allow_destroy: true

  # ----------------------- Callbacks --------------------
  
  before_create :author_is_admin
  before_update :editor_is_admin


  # ----------------------- Validations --------------------

  # validates :measurable_id, :measurable_type, :description, :unit_of_measure,
  #           presence: true
  
  # ----------------------- Virtual attributes --------------------

  def kfa_name
    objective.key_focus_area.name
  end
  
  def parents
    [objective.key_focus_area, objective]
  end

  # ----------------------- Class methods --------------------
  
  def self.filter_results(query, current_user)
    return where( data_contact_person_email: current_user.try(:email) ) if query[:filter_data_contact]
    all
  end

  # ----------------------- Instance methods --------------------
  

end
