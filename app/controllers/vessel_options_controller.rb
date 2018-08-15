class VesselOptionsController <  ApplicationController

  def create
    @vessel = Vessel.find(params[:vessel_id])
    @vessel_option = @vessel.vessel_options.new(vessel_option_params)
    if @vessel_option.save
      redirect_to vessel_path(params[:vessel_id])
    else
      @crews = Crew.all
      @vessel_options = VesselOption.where(vessel: @vessel)
      @booking = Booking.new
      @review = Review.new
      @booking.selected_options.build
      render "vessels/show"
    end
  end

  def destroy
    @vessel_option = VesselOption.find(params[:id])
    @vessel_option.destroy
    redirect_to vessel_path(params[:vessel_id])
  end

  private

  def vessel_option_params
    params.require(:vessel_option).permit(:option_id)
  end

end
