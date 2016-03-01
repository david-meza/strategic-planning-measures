class KeyFocusAreasController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @focus_areas = KeyFocusArea.all
  end

  def new
    @focus_area = KeyFocusArea.new
  end

  def create
  end

  def show
    @focus_area = KeyFocusArea.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def focus_area_params
    params.require(:key_focus_area).permit(:name, :goal)
  end


end
