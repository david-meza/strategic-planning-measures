class InitiativePlanningGuidesController < ApplicationController

  include AmazonSignature

  before_action :set_initiative_planning_guide, only: [:show, :edit, :update, :destroy]
  before_action :set_amazon_hash, only: [:new, :edit, :update, :create]

  def index
    @initiative_planning_guides = InitiativePlanningGuide.includes(:author, :last_editor, :initiative_plan_years, objective: :key_focus_area).order('key_focus_areas.name ASC, objectives.name ASC, initiative_planning_guides.description ASC')
  end

  def show
    respond_to do |format|
      format.html
      format.json
      format.pdf do
        render pdf:                            @initiative_planning_guide.description,
               template:                       'initiative_planning_guides/show.html.erb',
               layout:                         'pdf_layout',
               page_size:                      'Letter',
               show_as_html:                   params.key?('debug')
      end
    end
  end

  def new
    @initiative_planning_guide = InitiativePlanningGuide.new
    @implementation_team_contact = @initiative_planning_guide.humans.build(category: "Implementation Team Contact")
    @implementation_team_leads = @initiative_planning_guide.humans.build(category: "Implementation Team Leads")
    @extended_project_members = @initiative_planning_guide.humans.build(category: "Extended Project Members")
    @project_partners_internal = @initiative_planning_guide.humans.build(category: "Project Partners Internal")
    @project_partners_external = @initiative_planning_guide.humans.build(category: "Project Partners External")
    3.times { @initiative_planning_guide.goals_and_outcomes.build }
    # @goal = @initiative_planning_guide.goals_and_outcomes.build

    @humans = { "implementation_team_leads" => @implementation_team_leads, "implementation_team_contact" => @implementation_team_contact,
      "extended_project_members" => @extended_project_members, "project_partners_internal" => @project_partners_internal,
      "project_partners_external" => @project_partners_external }

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
      format.js   { render 'shared/destroy', locals: { resource: @initiative_planning_guide, data_label: "guide" } }
    end
  end

  private
    def set_initiative_planning_guide
      @initiative_planning_guide = InitiativePlanningGuide.find(params[:id])
    end

    def set_amazon_hash
      @hash = AmazonSignature::data_hash
    end

    def initiative_planning_guide_params
      params.fetch(:initiative_planning_guide, {}).permit(:objective_id, :description, :initiative_stage, 
                                                          :project_commitment, :initiative_overview, :major_milestones,
                                                          initiative_plan_years_attributes: [:id, :year], 
                                                          project_resources: [],
                                                          linked_measure_ids: [],
                                                          implementation_team_contact_attributes: [:id, :name, :email, :department, :category],
                                                          implementation_team_leads_attributes: [:id, :name, :email, :department, :category, :_destroy],
                                                          extended_project_members_attributes: [:id, :name, :email, :department, :category, :_destroy],
                                                          project_partners_internal_attributes: [:id, :name, :email, :department, :category, :_destroy],
                                                          project_partners_external_attributes: [:id, :name, :email, :department, :category, :_destroy],
                                                          goals_and_outcomes_attributes: [:id, :goal, :outcome, :_destroy]
                                                          )
    end
end
