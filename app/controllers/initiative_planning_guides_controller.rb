class InitiativePlanningGuidesController < ApplicationController
  before_action :set_initiative_planning_guide, only: [:show, :edit, :update, :destroy]

  def index
    @initiative_planning_guides = InitiativePlanningGuide.all
  end

  def show
  end

  def new
    @initiative_planning_guide = InitiativePlanningGuide.new
    @implementation_team_contact = @initiative_planning_guide.humans.build(category: "Implementation Team Contact")
    @implementation_team_leads = @initiative_planning_guide.humans.build(category: "Implementation Team Leads")
    @extended_project_members = @initiative_planning_guide.humans.build(category: "Extended Project Members")
    @project_partners_internal = @initiative_planning_guide.humans.build(category: "Project Partners Internal")
    @project_partners_external = @initiative_planning_guide.humans.build(category: "Project Partners External")

    @humans = {
      "implementation_team_leads" => @implementation_team_leads, "implementation_team_contact" => @implementation_team_contact,
      "extended_project_members" => @extended_project_members, "project_partners_internal" => @project_partners_internal,
      "project_partners_external" => @project_partners_external
    }

    respond_to do |format|
      format.html { render :new }
      format.js   { render :new_human_fields }
    end
  end

  def edit
  end

  def create
    @initiative_planning_guide = InitiativePlanningGuide.new(initiative_planning_guide_params)
    @initiative_planning_guide.author = current_user

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

  def update
    @initiative_planning_guide.last_editor = current_user

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

  def destroy
    @initiative_planning_guide.destroy
    respond_to do |format|
      format.html { redirect_to initiative_planning_guides_url, notice: 'Initiative planning guide was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_initiative_planning_guide
      @initiative_planning_guide = InitiativePlanningGuide.find(params[:id])
    end

    def initiative_planning_guide_params
      params.fetch(:initiative_planning_guide, {}).permit(:objective_id, :description, :initiative_stage, 
                                                          :project_commitment, :initiative_overview, :major_milestones,
                                                          initiative_plan_years_attributes: [:id, :year], 
                                                          project_resources: [],
                                                          implementation_team_contact_attributes: [:id, :name, :email, :department, :category],
                                                          implementation_team_leads_attributes: [:id, :name, :email, :department, :category, :_destroy],
                                                          extended_project_members_attributes: [:id, :name, :email, :department, :category, :_destroy],
                                                          project_partners_internal_attributes: [:id, :name, :email, :department, :category, :_destroy],
                                                          project_partners_external_attributes: [:id, :name, :email, :department, :category, :_destroy]
                                                          )
    end
end
