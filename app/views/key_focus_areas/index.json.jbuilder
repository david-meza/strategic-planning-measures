json.array!(@focus_areas) do |key_focus_area|
  json.merge! key_focus_area.as_json
  json.url key_focus_area_url(key_focus_area, format: :json)
end