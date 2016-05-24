class InitiativePlanningGuidesController < ApplicationController
  before_action :set_initiative_planning_guide, only: [:show, :edit, :update, :destroy]

  # GET /initiative_planning_guides
  # GET /initiative_planning_guides.json
  def index
    @initiative_planning_guides = InitiativePlanningGuide.all
  end

  # GET /initiative_planning_guides/1
  # GET /initiative_planning_guides/1.json
  def show
  end

  # GET /initiative_planning_guides/new
  def new
    @initiative_planning_guide = InitiativePlanningGuide.new
  end

  # GET /initiative_planning_guides/1/edit
  def edit
  end

  # POST /initiative_planning_guides
  # POST /initiative_planning_guides.json
  def create
    @initiative_planning_guide = InitiativePlanningGuide.new(initiative_planning_guide_params)

    respond_to do |format|
      if @initiative_planning_guide.save
        format.html { redirect_to @initiative_planning_guide, notice: 'Initiative planning guide was successfully created.' }
        format.json { render :show, status: :created, location: @initiative_planning_guide }
      else
        format.html { render :new }
        format.json { render json: @initiative_planning_guide.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /initiative_planning_guides/1
  # PATCH/PUT /initiative_planning_guides/1.json
  def update
    respond_to do |format|
      if @initiative_planning_guide.update(initiative_planning_guide_params)
        format.html { redirect_to @initiative_planning_guide, notice: 'Initiative planning guide was successfully updated.' }
        format.json { render :show, status: :ok, location: @initiative_planning_guide }
      else
        format.html { render :edit }
        format.json { render json: @initiative_planning_guide.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /initiative_planning_guides/1
  # DELETE /initiative_planning_guides/1.json
  def destroy
    @initiative_planning_guide.destroy
    respond_to do |format|
      format.html { redirect_to initiative_planning_guides_url, notice: 'Initiative planning guide was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_initiative_planning_guide
      @initiative_planning_guide = InitiativePlanningGuide.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def initiative_planning_guide_params
      params.require(:initiative_planning_guide).permit(:objective_id, :initiative_stage, :implementation_team_contact_person, :string, :project_commitment, :project_resources, :initiative_overview, :major_milestones)
    end
end
