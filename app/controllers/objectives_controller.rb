class ObjectivesController < ApplicationController
  
  before_action :set_objective, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_admin, except: [:index, :show]


  # GET /objectives
  # GET /objectives.json
  def index
    @objectives = params[:key_focus_area_id] ? 
                  Objective.where(key_focus_area_id: params[:key_focus_area_id]).order(name: :asc) : 
                  Objective.includes(:key_focus_area, :author, :last_editor).order("key_focus_areas.name asc, objectives.name asc, objectives.updated_at desc")
  end

  # GET /objectives/1
  # GET /objectives/1.json
  def show
  end

  # GET /objectives/new
  def new
    @objective = Objective.new
  end

  # GET /objectives/1/edit
  def edit
  end

  # POST /objectives
  # POST /objectives.json
  def create
    @objective = Objective.new(objective_params)
    @objective.author = current_user

    respond_to do |format|
      if @objective.save
        format.html { redirect_to @objective, notice: 'Objective was successfully created.' }
        format.json { render :show, status: :created, location: @objective }
      else
        format.html { render :new }
        format.json { render json: @objective.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /objectives/1
  # PATCH/PUT /objectives/1.json
  def update
    @objective.last_editor = current_user

    respond_to do |format|
      if @objective.update(objective_params)
        format.html { redirect_to @objective, notice: 'Objective was successfully updated.' }
        format.json { render :show, status: :ok, location: @objective }
      else
        format.html { render :edit }
        format.json { render json: @objective.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /objectives/1
  # DELETE /objectives/1.json
  def destroy
    @objective.destroy
    respond_to do |format|
      format.html { redirect_to objectives_url, notice: 'Objective was successfully deleted.' }
      format.json { head :no_content }
      format.js   { render 'shared/destroy', locals: { resource: @objective, data_label: "objective" } }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_objective
      @objective = Objective.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def objective_params
      params.fetch(:objective, {}).permit(:key_focus_area_id, :name, :description)
    end
end
