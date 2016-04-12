class KeyFocusAreasController < ApplicationController

  before_action :set_focus_area, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_admin, except: [:index, :show]

  def index
    @focus_areas = KeyFocusArea.includes(:objectives, :measures, :author, :last_editor).order(name: :asc, updated_at: :desc)
  end

  def new
    @focus_area = KeyFocusArea.new
  end

  def create
    @focus_area = KeyFocusArea.new(focus_area_params)
    @focus_area.author = current_user

    respond_to do |format|
      if @focus_area.save
        format.html { redirect_to @focus_area, notice: 'Key focus area was successfully created.' }
        format.json { render :show, status: :created, location: @focus_area }
      else
        format.html { render :new }
        format.json { render json: @focus_area.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    @focus_area.last_editor = current_user

    respond_to do |format|
      if @focus_area.update(focus_area_params)
        format.html { redirect_to @focus_area, notice: 'Key focus area was successfully updated.' }
        format.json { render :show, status: :created, location: @focus_area }
      else
        format.html { render :edit }
        format.json { render json: @focus_area.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @focus_area.destroy
    respond_to do |format|
      format.html { redirect_to key_focus_areas_url, notice: 'Key focus area was successfully deleted.' }
      format.json { head :no_content }
      format.js   { render 'shared/destroy', locals: { resource: @focus_area, data_label: "kfa" } }
    end
  end

  private

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_focus_area
      @focus_area = KeyFocusArea.find(params[:id])
    end

    def focus_area_params
      params.fetch(:key_focus_area, {}).permit(:name, :goal, :logo)
    end

end
