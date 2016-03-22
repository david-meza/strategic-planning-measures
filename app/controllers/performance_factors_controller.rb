class PerformanceFactorsController < ApplicationController
  before_action :set_performance_factor, only: [:show, :edit, :update, :destroy]

  # GET /performance_factors
  # GET /performance_factors.json
  def index
    @performance_factors = PerformanceFactor.all
  end

  # GET /performance_factors/1
  # GET /performance_factors/1.json
  def show
  end

  # GET /performance_factors/new
  def new
    @performance_factor = PerformanceFactor.new
  end

  # GET /performance_factors/1/edit
  def edit
  end

  # POST /performance_factors
  # POST /performance_factors.json
  def create
    @performance_factor = PerformanceFactor.new(performance_factor_params)

    respond_to do |format|
      if @performance_factor.save
        format.html { redirect_to @performance_factor, notice: 'Performance factor was successfully created.' }
        format.json { render :show, status: :created, location: @performance_factor }
      else
        format.html { render :new }
        format.json { render json: @performance_factor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /performance_factors/1
  # PATCH/PUT /performance_factors/1.json
  def update
    respond_to do |format|
      if @performance_factor.update(performance_factor_params)
        format.html { redirect_to @performance_factor, notice: 'Performance factor was successfully updated.' }
        format.json { render :show, status: :ok, location: @performance_factor }
      else
        format.html { render :edit }
        format.json { render json: @performance_factor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /performance_factors/1
  # DELETE /performance_factors/1.json
  def destroy
    @performance_factor.destroy
    respond_to do |format|
      format.html { redirect_to performance_factors_url, notice: 'Performance factor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_performance_factor
      @performance_factor = PerformanceFactor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def performance_factor_params
      params.require(:performance_factor).permit(:performance_measure_id, :label_text, :field_type)
    end
end
