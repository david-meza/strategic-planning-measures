json.array!(@initiative_planning_guides) do |initiative_planning_guide|
  json.extract! initiative_planning_guide, :id, :initiative_stage, :project_commitment, :description
  json.year initiative_planning_guide.years.last.year unless initiative_planning_guide.years.empty?
  json.url initiative_planning_guide_url(initiative_planning_guide, format: :json)
end
