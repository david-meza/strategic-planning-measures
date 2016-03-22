class PerformanceFactorEntriesController < ApplicationController
  before_action :set_performance_factor_entry, only: [:show, :edit, :update, :destroy]

  # GET /performance_factor_entries
  # GET /performance_factor_entries.json
  def index
    @performance_factor_entries = PerformanceFactorEntry.all
  end

  # GET /performance_factor_entries/1
  # GET /performance_factor_entries/1.json
  def show
  end

  # GET /performance_factor_entries/new
  def new
    @performance_factor_entry = PerformanceFactorEntry.new
  end

  # GET /performance_factor_entries/1/edit
  def edit
  end

  # POST /performance_factor_entries
  # POST /performance_factor_entries.json
  def create
    @performance_factor_entry = PerformanceFactorEntry.new(performance_factor_entry_params)

    respond_to do |format|
      if @performance_factor_entry.save
        format.html { redirect_to @performance_factor_entry, notice: 'Performance factor entry was successfully created.' }
        format.json { render :show, status: :created, location: @performance_factor_entry }
      else
        format.html { render :new }
        format.json { render json: @performance_factor_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /performance_factor_entries/1
  # PATCH/PUT /performance_factor_entries/1.json
  def update
    respond_to do |format|
      if @performance_factor_entry.update(performance_factor_entry_params)
        format.html { redirect_to @performance_factor_entry, notice: 'Performance factor entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @performance_factor_entry }
      else
        format.html { render :edit }
        format.json { render json: @performance_factor_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /performance_factor_entries/1
  # DELETE /performance_factor_entries/1.json
  def destroy
    @performance_factor_entry.destroy
    respond_to do |format|
      format.html { redirect_to performance_factor_entries_url, notice: 'Performance factor entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_performance_factor_entry
      @performance_factor_entry = PerformanceFactorEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def performance_factor_entry_params
      params.require(:performance_factor_entry).permit(:performance_factor_id, :measure_report_id, :data, :comments)
    end
end
