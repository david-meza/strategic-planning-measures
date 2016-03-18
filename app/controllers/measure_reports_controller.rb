class MeasureReportsController < ApplicationController
  
  before_action :set_measure_report, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /measure_reports
  # GET /measure_reports.json
  def index
    @measure_reports = MeasureReport.order(updated_at: :desc).paginate(:page => params[:page], :per_page => 12)
  end

  # GET /measure_reports/1
  # GET /measure_reports/1.json
  def show
  end

  # GET /measure_reports/new
  def new
    @measure_report = MeasureReport.new
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
    @measure_report.destroy
    respond_to do |format|
      format.html { redirect_to measure_reports_url, notice: 'Measure report was successfully destroyed.' }
      format.js   { render :destroy, :locals => { id: params[:id] } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_measure_report
      @measure_report = MeasureReport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def measure_report_params
      params.fetch(:measure_report, {}).permit(:performance_measure_id, :performance, :status, :date_start, :date_end, :comments, :bms_comments)
    end
end
