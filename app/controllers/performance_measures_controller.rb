class PerformanceMeasuresController < ApplicationController
  
  before_action :set_performance_measure, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_admin, except: [:index, :show]

  def index
    @performance_measures = 
    if params[:measurable_id] && params[:measurable_type]
      PerformanceMeasure.where(measurable_id: params[:measurable_id], measurable_type: params[:measurable_type]).order(description: :asc)
    else
      PerformanceMeasure.filter_results(allowed_query_params, current_user).includes(:key_focus_area, objective: :key_focus_area).order("key_focus_areas.name ASC, key_focus_areas_objectives.name ASC, objectives.name ASC")
    end
  end

  def performance_measures
    @performance_measures = PerformanceMeasure.includes(:author, :last_editor, :key_focus_area, objective: :key_focus_area).order('key_focus_areas.name ASC, key_focus_areas_objectives.name ASC, objectives.name ASC')

    respond_to do |format|
      format.csv { send_data @performance_measures.to_csv }
      format.xls
    end
  end

  def show
  end

  def new
    @performance_measure = PerformanceMeasure.new
    @performance_measure.performance_factors.build

    respond_to do |format|
      format.html { render :new }
      format.js   { render :new_factor_fields }
    end
  end

  def edit
  end

  def create
    @performance_measure = PerformanceMeasure.new(performance_measure_params)
    @performance_measure.author = current_user

    respond_to do |format|
      if @performance_measure.save
        format.html { redirect_to @performance_measure, notice: 'Performance measure was successfully created.' }
        format.json { render :show, status: :created, location: @performance_measure }
      else
        format.html { render :new }
        format.json { render json: @performance_measure.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @performance_measure.last_editor = current_user

    respond_to do |format|
      if @performance_measure.update(performance_measure_params)
        format.html { redirect_to @performance_measure, notice: 'Performance measure was successfully updated.' }
        format.json { render :show, status: :ok, location: @performance_measure }
        format.js   { render 'shared/update', locals: { resource: @performance_measure, data_label: "measure" } }
      else
        format.html { render :edit }
        format.json { render json: @performance_measure.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @performance_measure.destroy
    respond_to do |format|
      format.html { redirect_to performance_measures_url, notice: 'Performance measure was successfully deleted.' }
      format.json { head :no_content }
      format.js   { render 'shared/destroy', locals: { resource: @performance_measure, data_label: "measure" } }
    end
  end

  private
    def set_performance_measure
      @performance_measure = PerformanceMeasure.includes(:author, :last_editor, :performance_factors).find(params[:id])
    end

    def performance_measure_params
      params.fetch(:performance_measure, {}).permit(:measurable_id, :measurable_type, :description, :target, :unit_of_measure, :frequency_data_available,
                                                    :measurement_formula, :data_source, :rationale_for_target, :data_contact_person, 
                                                    :data_contact_person_email, :person_reporting_data_to_bms, :person_reporting_data_to_bms_email, 
                                                    :notes, performance_factors_attributes: [:id, :_destroy, :label_text, :field_type] )
    end

    def allowed_query_params
      params.permit(:measurable_id, :measurable_type, :filter_data_contact)
    end
end
