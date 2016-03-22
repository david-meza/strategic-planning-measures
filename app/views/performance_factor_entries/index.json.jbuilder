json.array!(@performance_factor_entries) do |performance_factor_entry|
  json.extract! performance_factor_entry, :id, :performance_factor_id, :measure_report_id, :data, :comments
  json.url performance_factor_entry_url(performance_factor_entry, format: :json)
end
