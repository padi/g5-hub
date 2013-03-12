class LocationsController < ApplicationController
  def show
    @client = Client.find_by_urn(params[:client_id]).decorate
    @location = Location.find_by_urn(params[:id]).decorate
  end
end
