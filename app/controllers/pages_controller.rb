class PagesController < ApplicationController
  #skip_before_action :authenticate_user!, only: [:home]

  def home
    @vessels = Vessel.all.first(3);
  end
end
