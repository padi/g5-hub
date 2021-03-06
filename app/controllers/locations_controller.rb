class LocationsController < ApplicationController
  before_filter :load_client, :load_location

  def show
    @client   = @client.decorate
    @location = @location.decorate

    respond_to do |format|
      format.html
      format.json { render json: @location, serializer: LocationSerializer }
    end
  end

  private
  def load_client
    @client = Client.find_by_urn!(params[:client_id])
  end

  def load_location
    @location = @client.locations.find_by_urn!(params[:id])
  end
end
