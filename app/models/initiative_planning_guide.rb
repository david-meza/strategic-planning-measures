class InitiativePlanningGuide < ActiveRecord::Base
  
  belongs_to :objective

  has_many  :humans,
            dependent: :destroy,
            class_name: 'InitiativeHuman'

  has_one :implementation_team_contact, 
          -> { where category: "Implementation Team Contact"},
          class_name: 'InitiativeHuman'

  has_many  :implementation_team_leads,
            -> { where category: "Implementation Team Leads"},
            class_name: 'InitiativeHuman'

  has_many  :extended_project_members,
            -> { where category: "Extended Project Members"},
            class_name: 'InitiativeHuman'

  has_many  :project_partners_internal,
            -> { where category: "Project Partners Internal"},
            class_name: 'InitiativeHuman'

  has_many  :project_partners_external,
            -> { where category: "Project Partners External"},
            class_name: 'InitiativeHuman'

  has_many :initiative_plan_years,
            class_name: 'InitiativePlanYear'

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  include UserRules

  accepts_nested_attributes_for :initiative_plan_years,
                                reject_if: :reject_year

  accepts_nested_attributes_for :implementation_team_contact

  accepts_nested_attributes_for :implementation_team_leads,
                                allow_destroy: true,
                                reject_if: :all_blank

  accepts_nested_attributes_for :extended_project_members,
                                allow_destroy: true,
                                reject_if: :all_blank

  accepts_nested_attributes_for :project_partners_internal,
                                allow_destroy: true,
                                reject_if: :all_blank

  accepts_nested_attributes_for :project_partners_external,
                                allow_destroy: true,
                                reject_if: :all_blank

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

  def project_resources=(new_tags)
    self.tag_ids = new_tags.reject(&:blank?)
  end

  def project_resources
    self.tag_ids
  end

  def project_resources_models
    self.tags
  end

  # ----------------------- Class methods --------------------
  
  def self.filter_results(query, current_user)
    return where( data_contact_person_email: current_user.try(:email) ) if query[:filter_data_contact]
    all
  end

  def self.project_resource_values
    [ Tag.find_or_create_by(name: "Available within existing budget and resources", use_case: "project_resources"), 
      Tag.find_or_create_by(name: "Will require new staffing or resources", use_case: "project_resources"), 
      Tag.find_or_create_by(name: "Will require re-allocation of existing staffing or resources", use_case: "project_resources") ]
  end

  # ----------------------- Instance methods --------------------
  
  def reject_year(attributes)
    self.initiative_plan_years.last.update({expired: true, date_expired: Time.now}) unless self.initiative_plan_years.last.nil?
    attributes['year'].blank?
  end

end
