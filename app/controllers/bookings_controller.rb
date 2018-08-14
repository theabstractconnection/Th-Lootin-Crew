class BookingsController < ApplicationController
  before_action :set_booking, only: [:show]
  before_action :authenticate_user!, only: [:show, :create]

  # POST /vessels
  def show
  end

  def create
    @vessel = Vessel.find(booking_params[:vessel_id])
    @booking = current_user.bookings.new(booking_params)

    if @booking.save
      redirect_to booking_path(@booking), notice: 'booking was successfully created.'
    else
      redirect_to vessel_path(@vessel)
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_booking
    @booking = Booking.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :vessel_id)
  end
end
