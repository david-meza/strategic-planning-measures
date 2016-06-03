class MeasureReportsController < ApplicationController
  
  before_action :set_measure_report, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  # before_action :authenticate_admin, only: :destroy
  before_action :authenticate_author, only: [:edit, :update, :destroy]

  # GET /measure_reports
  # GET /measure_reports.json
  def index
    @measure_reports = MeasureReport.filter_query(query_params).includes(:author, :last_editor, performance_measure: [:key_focus_area, objective: :key_focus_area]).where(expired: false).order('key_focus_areas.name ASC, key_focus_areas_objectives.name ASC, objectives.name ASC').paginate(:page => params[:page], :per_page => 12)
  end

  def measure_reports
    @measure_reports = MeasureReport.includes(:author, :last_editor, performance_measure: [:key_focus_area, objective: :key_focus_area]).order('key_focus_areas.name ASC, key_focus_areas_objectives.name ASC, objectives.name ASC')

    respond_to do |format|
      format.csv { send_data @measure_reports.to_csv }
      format.xls
    end

  end

  # GET /measure_reports/1
  # GET /measure_reports/1.json
  def show
  end

  # GET /measure_reports/new
  def new
    @measure_report = MeasureReport.new
    @measure_report.performance_factor_entries.build
    @measure_report.performance_measure_id = params[:measure_id] if params[:measure_id]

    respond_to do |format|
      format.html { render :new }
      format.js   { render :new_factor_entry_fields }
    end
  end

  # GET /measure_reports/1/edit
  def edit
  end

  # POST /measure_reports
  # POST /measure_reports.json
  def create
    @measure_report = MeasureReport.new(measure_report_params)
    @measure_report.created_by_user_id = current_user.id

    respond_to do |format|
      if @measure_report.save
        format.html { redirect_to @measure_report, notice: 'Measure report was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @measure_report }
      else
        flash[:alert] = @measure_report.errors.full_messages.map { |error| "<li>#{error}</li>".html_safe }.join
        format.html { render :new }
        format.js   { render :form_error }
        format.json { render json: @measure_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /measure_reports/1
  # PATCH/PUT /measure_reports/1.json
  def update
    @measure_report.last_editor = current_user
    respond_to do |format|
      if @measure_report.update(measure_report_params)
        format.html { redirect_to @measure_report, notice: 'Measure report was successfully updated.' }
        format.json { render :show, status: :ok, location: @measure_report }
      else
        format.html { render :edit }
        format.json { render json: @measure_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /measure_reports/1
  # DELETE /measure_reports/1.json
  def destroy
    @measure_report.last_editor = current_user
    @measure_report.update({expired: true})
    respond_to do |format|
      format.html { redirect_to measure_reports_url, notice: 'Measure report was successfully deleted.' }
      format.js   { render 'shared/destroy', locals: { resource: @measure_report, data_label: "report" } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_measure_report
      @measure_report = MeasureReport.find(params[:id])
    end

    # Only allow the author to edit their own report
    def authenticate_author
      unless current_user.try(:admin?) || @measure_report.author == current_user
        flash[:notice] = "You cannot edit someone else's report with your current credentials"
        redirect_to referer
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def measure_report_params
      params.fetch(:measure_report, {}).permit( :performance_measure_id, :performance, :status, 
                                                :date_start, :date_end, :comments, :bms_comments,
                                                performance_factor_entries_attributes: [:id, :_destroy, :data, :performance_factor_id, :comments])
    end

    def query_params
      params.fetch(:query, {}).permit('key_focus_areas.id', 'objectives.id', 'performance_measures.id', 'measure_reports.id', 'author.id')
    end
end
