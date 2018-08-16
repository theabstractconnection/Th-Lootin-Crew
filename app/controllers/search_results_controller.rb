class SearchResultsController < ApplicationController
  def query

    redirect_to root_path and return if params[:query].blank?

    query = "%#{params[:query]}%"
    v = Vessel.arel_table
    o = VesselOption.arel_table

    @vessels =  Vessel.joins(:vessel_options).where(
      v[:name].matches(query).
      or(v[:address].matches(query))
    ).distinct

    if  @vessels.empty?
      @vessels = Vessel.all
      redirect_to vessels_path, notice: "Sorry We coundn't find any Vessel matching your search"  and return
    end

    render 'vessels/index'
  end
end
