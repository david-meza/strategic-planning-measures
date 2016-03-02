json.array!(@objectives) do |objective|
  json.extract! objective, :id, :key_focus_area_id, :name, :description
  json.url objective_url(objective, format: :json)
end
