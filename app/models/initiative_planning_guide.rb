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

  has_many :initiative_plan_years
  has_many :initiative_humans

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  include UserRules

  accepts_nested_attributes_for :initiative_plan_years,
                                reject_if: proc { |attributes| attributes['year'].blank? }

  accepts_nested_attributes_for :implementation_team_contact

  accepts_nested_attributes_for :implementation_team_leads,
                                allow_destroy: true,
                                reject_if: :all_blank

  accepts_nested_attributes_for :extended_project_members,
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

  def project_resources=(names)
    self.tags = names.reject(&:blank?).map do |name|
      tag = Tag.find_or_create_by(name: name.strip)
      Tagging.find_or_create_by({ initiative_planning_guide: self, tag: tag})
    end
  end

  def project_resources
    self.tags
  end

  # ----------------------- Class methods --------------------
  
  def self.filter_results(query, current_user)
    return where( data_contact_person_email: current_user.try(:email) ) if query[:filter_data_contact]
    all
  end

  # ----------------------- Instance methods --------------------
  

end
