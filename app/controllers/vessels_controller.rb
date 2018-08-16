class VesselsController < ApplicationController
  before_action :set_vessel, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  # GET /vessels
  def index
    @vessels = Vessel.where.not(latitude: nil, longitude: nil)

    @markers = @vessels.map do |vessel|
      {
        lat: vessel.latitude,
        lng: vessel.longitude,
        infoWindow: { content: render_to_string(partial: "/vessels/map_box", locals: { vessel: vessel }) }
      }
    end
  end

  # GET /vessels/1
  def show
    @crews = Crew.first(3)
    @vessel_options = VesselOption.where(vessel: @vessel)
    @vessel_option = VesselOption.new
    @booking = Booking.new
    @review = Review.new
    @booking.selected_options.build
    @markers =
      [{
        lat: @vessel.latitude,
        lng: @vessel.longitude,
        infoWindow: { content: render_to_string(partial: "/vessels/map_box", locals: { vessel: @vessel }) }
      }]
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
    # address = vessel_params[:address]
    # g_code = geocode(address)
    # if g_code
    #   @vessel.latitude = g_code[:latitude]
    #   @vessel.longitude = g_code[:longitude]
    # else
    #   redirect_to new_vessel_path, notice:"We can't Geocode this city... Try Again"  and return
    # end

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

  def search
    Vessel.reindex
    @vessels =  Vessel.search(params[:query])
    @markers = @vessels.map do |vessel|
     {
      lat: vessel.latitude,
        lng: vessel.longitude#,
        # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
      }
    end
    render :index, vessel: @vessel, markers:@markers
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_vessel
    @vessel = Vessel.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def vessel_params
    params.require(:vessel).permit(:name, :description, :price, :photo, :photo_cache, :category, :address)
  end

end
