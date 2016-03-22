json.array!(@performance_factors) do |performance_factor|
  json.extract! performance_factor, :id, :performance_measure_id, :label_text, :field_type
  json.url performance_factor_url(performance_factor, format: :json)
end
