class LocationsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @client = Client.find_by_urn!(params[:client_id]).decorate
    @location = Location.find_by_urn!(params[:id]).decorate
  end
end
