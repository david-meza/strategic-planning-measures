class PerformanceMeasuresController < ApplicationController
  
  before_action :set_performance_measure, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_admin, except: [:index, :show]

  # GET /performance_measures
  # GET /performance_measures.json
  def index
    @performance_measures = 
    if params[:measurable_id] && params[:measurable_type]
      PerformanceMeasure.where(measurable_id: params[:measurable_id], measurable_type: params[:measurable_type])
    else
      PerformanceMeasure.includes(:key_focus_area, :objective).order("key_focus_areas.name asc, objectives.key_focus_area_id asc, objectives.name asc, performance_measures.updated_at desc")
    end
  end

  # GET /performance_measures/1
  # GET /performance_measures/1.json
  def show
  end

  # GET /performance_measures/new
  def new
    @performance_measure = PerformanceMeasure.new
  end

  # GET /performance_measures/1/edit
  def edit
  end

  # POST /performance_measures
  # POST /performance_measures.json
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

  # PATCH/PUT /performance_measures/1
  # PATCH/PUT /performance_measures/1.json
  def update
    @performance_measure.last_editor = current_user

    respond_to do |format|
      if @performance_measure.update(performance_measure_params)
        format.html { redirect_to @performance_measure, notice: 'Performance measure was successfully updated.' }
        format.json { render :show, status: :ok, location: @performance_measure }
      else
        format.html { render :edit }
        format.json { render json: @performance_measure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /performance_measures/1
  # DELETE /performance_measures/1.json
  def destroy
    @performance_measure.destroy
    respond_to do |format|
      format.html { redirect_to performance_measures_url, notice: 'Performance measure was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_performance_measure
      @performance_measure = PerformanceMeasure.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def performance_measure_params
      params.fetch(:performance_measure, {}).permit(:measurable_id, :measurable_type, :description, :target, :unit_of_measure, :measurement_formula, :data_source, :rationale_for_target, :data_contact_person, :data_contact_person_email, :person_reporting_data_to_bms, :person_reporting_data_to_bms_email, :notes)
    end
end
