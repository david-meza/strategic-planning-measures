class PerformanceMeasure < ActiveRecord::Base

  # ----------------------- Associations --------------------

  belongs_to  :measurable, 
              polymorphic: true

  belongs_to  :key_focus_area, 
              -> { where(performance_measures: { measurable_type: :KeyFocusArea }) }, 
              foreign_key: 'measurable_id'
  
  belongs_to  :objective, 
              -> { where(performance_measures: { measurable_type: :Objective }) }, 
              foreign_key: 'measurable_id'

  include UserRules

  has_many  :measure_reports, 
            dependent: :destroy
  
  has_many  :performance_factors, 
            dependent: :destroy

  has_many  :initiative_linked_measures,
            dependent: :destroy

  has_many  :initiatives_linked,
            through: :initiative_linked_measures,
            source: :initiative_planning_guide

  accepts_nested_attributes_for :performance_factors,
                                reject_if: :all_blank,
                                allow_destroy: true

  # ----------------------- Callbacks --------------------
  
  before_create :author_is_admin
  before_update :editor_is_admin


  # ----------------------- Validations --------------------

  validates :measurable_id, :measurable_type, :description, :unit_of_measure,
            presence: true
  
  # ----------------------- Virtual attributes --------------------

  def kfa_name
    return measurable.name if measurable_type == "KeyFocusArea"
    measurable.key_focus_area.name
  end
  
  def parents
    # Display N/A in objectives for those measures that target directly a KFA
    # dummy = OpenStruct.new( { name: "N/A", model_name: OpenStruct.new({ human: "Objective" }) })
    dummy = Objective.new(name: "N/A")
    return [measurable, dummy] if measurable_type == "KeyFocusArea"
    [measurable.key_focus_area, measurable]
  end

  # ----------------------- Class methods --------------------
  
  def self.filter_results(query, current_user)
    return where( data_contact_person_email: current_user.try(:email) ) if query[:filter_data_contact]
    all
  end

  # ----------------------- Instance methods --------------------
  

end
