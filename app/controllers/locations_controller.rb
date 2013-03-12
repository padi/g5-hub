class LocationsController < ApplicationController
  def show
    @location = Location.find_by_urn(params[:id]).decorate
  end
end
