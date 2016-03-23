module PerformanceMeasuresHelper

  def link_to_add_fields(measure)
    fields_for(measure) do |measure_fields|
      measure_fields.fields_for(:performance_factors, :child_index => Time.now.to_i) do |factor_fields|
        render partial: "factor_fields", locals: { factor_fields: factor_fields }
      end
    end
  end

end
