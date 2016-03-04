json.array!(@performance_measures) do |performance_measure|
  json.merge! performance_measure.as_json
  json.url performance_measure_url(performance_measure, format: :json)
end
