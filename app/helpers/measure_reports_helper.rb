module MeasureReportsHelper

  def factor_entry_fields(report)
    fields_for report do |report_fields|
      return render partial: "factor_entry_fields", locals: { report_fields: report_fields, measure_report: report }
    end
  end

  def formatted_date(date)
    date.strftime("%B %Y")
  end

  def pattern_for_field_type(field_type)
    field_type == 'number' ? "(?:\\+|\\-|\\$)?\\d{1,}(?:\\,?\\d{3})*(?:\\.\\d+)?%?" : ".+"
  end

end
