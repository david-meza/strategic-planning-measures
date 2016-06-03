json.array!(@initiative_planning_guides) do |initiative_planning_guide|
  json.extract! initiative_planning_guide, :id, :objective_id, :initiative_stage, :implementation_team_contact_person, :string, :project_commitment, :project_resources, :initiative_overview, :major_milestones
  json.url initiative_planning_guide_url(initiative_planning_guide, format: :json)
end
