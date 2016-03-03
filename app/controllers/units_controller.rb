class UnitsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_building

  # GET /units
  # GET /units.json
  def index
    @units = @building.units
  end

  # GET /units/1
  # GET /units/1.json
  def show
    set_unit
  end

  # GET /units/new
  def new
    @unit = Unit.new
  end

  # GET /units/1/edit
  def edit
    set_unit
  end

  # POST /units
  # POST /units.json
  def create
    @unit = @building.units.new(unit_params)

    respond_to do |format|
      if @unit.save
        format.html { redirect_to [@building, @unit], notice: 'Unit was successfully created.' }
        format.json { render :show, status: :created, location: [@building, @unit] }
      else
        format.html { render :new }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /units/1
  # PATCH/PUT /units/1.json
  def update
    set_unit

    respond_to do |format|
      if @unit.update(unit_params)
        format.html { redirect_to [@building, @unit], notice: 'Unit was successfully updated.' }
        format.json { render :show, status: :ok, location: [@building, @unit] }
      else
        format.html { render :edit }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /units/1
  # DELETE /units/1.json
  def destroy
    set_unit

    @unit.destroy
    respond_to do |format|
      format.html { redirect_to building_units_url(@building), notice: 'Unit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit
      @unit = @building.units.find(params[:id])
    end

    def set_building
      @building = Building.find(params[:building_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def unit_params
      params.require(:unit).permit(:building_id, :unit_number)
    end
end
