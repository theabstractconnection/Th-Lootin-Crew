require 'httparty'

class VesselsController < ApplicationController
  before_action :set_vessel, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  # GET /vessels
  def index
    @vessels = Vessel.all
  end

  # GET /vessels/1
  def show
    @crews = Crew.all
    @vessel_options = VesselOption.where(vessel: @vessel)
    @booking = Booking.new
    @review = Review.new
    @booking.selected_options.build
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
    @vessel = current_user.vessels.new(vessel_params)
    city = vessel_params[:city]
    g_code = geocode(city)
    if g_code
      @vessel.lat = g_code[:lat]
      @vessel.lng = g_code[:lng]
    else
      redirect_to new_vessel_path, notice:"We can't Geocode this city... Try Again"  and return
    end

    if @vessel.save
      redirect_to @vessel, notice: 'Vessel was successfully created.'
    else
      render :new, notice:"Something Went Wrong... Try Again"
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
    params.require(:vessel).permit(:name, :description, :price, :photo, :photo_cache, :category, :city)
  end

  def geocode(city)
    baseUrl = "https://maps.googleapis.com/maps/api/geocode/json?address="
    response = HTTParty.get(baseUrl+city).parsed_response.deep_symbolize_keys
    result = response[:results].first
    unless result then return nil end
    {lat: result[:geometry][:location][:lat], lng: result[:geometry][:location][:lng]}
  end
end
