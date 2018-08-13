class VesselsController < ApplicationController
  before_action :set_vessel, only: [:show, :edit, :update, :destroy]

  # GET /vessels
  def index
    @vessels = Vessel.all
  end

  # GET /vessels/1
  def show
  end

  # GET /vessels/new
  def new
    @vessel = Vessel.new
  end

  # GET /vessels/1/edit
  def edit
  end

  # POST /vessels
  def create
    @vessel = Vessel.new(vessel_params)

    if @vessel.save
      redirect_to @vessel, notice: 'Vessel was successfully created.'
    else
      render :new
    end

  end

  # PATCH/PUT /vessels/1
  def update
    if @vessel.update(vessel_params)
      redirect_to @vessel, notice: 'Vessel was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /vessels/1
  def destroy
    @vessel.destroy
    redirect_to vessels_url, notice: 'Vessel was successfully destroyed.'
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_vessel
    @vessel = Vessel.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def vessel_params
    params.require(:vessel).permit(:name, :description, :price)
  end
end