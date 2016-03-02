json.array!(@performance_measures) do |performance_measure|
  json.extract! performance_measure, :id, :measurable_id, :measurable_type, :description, :target, :unit_of_measure, :measurement_formula, :data_source, :rationale_for_target, :data_contact_person, :person_reporting_data_to_bms, :notes, :created_by_user_id
  json.url performance_measure_url(performance_measure, format: :json)
end
