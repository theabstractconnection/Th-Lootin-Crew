class PagesController < ApplicationController
  #skip_before_action :authenticate_user!, only: [:home]

  def home
    @vessels = Vessel.all.first(3);
  end

  def dashboard
    @bookings = current_user.bookings
    @vessels = current_user.vessels
  end


end
