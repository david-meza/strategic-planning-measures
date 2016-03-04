json.array!(@objectives) do |objective|
  json.merge! objective.as_json
  json.url objective_url(objective, format: :json)
end
