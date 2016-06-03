module InitiativePlanningGuidesHelper

  def planning_guide_parents(action, initiative_fields)
    if action == 'new' || action == 'create'
      render partial: 'parents_new', locals: { initiative_fields: initiative_fields}
    else
      render partial: 'parents_display', locals: { initiative_fields: initiative_fields}
    end
  end

  def last_submitted_year(initiative_guide)
    if initiative_guide.persisted?
      render partial: 'update_plan_year', locals: { initiative_guide: initiative_guide }
    end
  end

  def last_two_year_updates(initiative_guide)
    all_submitted_years = initiative_guide.initiative_plan_years
    last_years = (all_submitted_years.length >= 3 ? all_submitted_years[-3..-2] : [all_submitted_years[-2]]).reject(&:nil?)
    last_years.each do |plan_year|
      concat content_tag(:p, "Goal had been set to #{plan_year.year} on #{plan_year.created_at.strftime('%b %-d, %Y')}", class: "striked-text")
    end
  end

  def render_new_human_fields(planning_guide, human_builder, selector)
    fields_for(planning_guide) do |initiative_fields|
      initiative_fields.fields_for(selector, human_builder, :child_index => Time.now.to_i) do |human_fields|
        render partial: "initiative_humans_fields", locals: { fields: human_fields }
      end
    end
  end

  def str_to_sym(str)
    str.downcase.gsub(/\s+/, "_").to_sym
  end

  def db_to_commitment(str)
    { "once" => "One-Time Commitment", "ongoing" => "Ongoing Commitment" }[str]
  end
end
