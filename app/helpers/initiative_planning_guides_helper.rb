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
      content_tag(:p, class: "editable-year layout-row layout-align-space-between-start") do
        concat content_tag(:p, initiative_guide.initiative_plan_years[-2].try(:year))
        concat content_tag(:a, "Update Year")
      end
    end
  end

end
