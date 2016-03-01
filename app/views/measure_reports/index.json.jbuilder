json.array!(@measure_reports) do |measure_report|
  json.extract! measure_report, :id
  json.url measure_report_url(measure_report, format: :json)
end
