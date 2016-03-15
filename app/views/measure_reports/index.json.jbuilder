json.array!(@measure_reports) do |measure_report|
  json.merge! measure_report.as_json
  json.url measure_report_url(measure_report, format: :json)
end
