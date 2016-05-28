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

end
