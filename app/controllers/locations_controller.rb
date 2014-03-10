class LocationsController < ApplicationController
  def show
    @client = Client.find_by_urn(params[:client_id]).decorate
    @location = Location.find_by_urn(params[:id]).decorate
  end
end

private

  def location_params
    params.require(:location).permit(:client_id, :name, :street_address_1, :street_address_2,
    :city, :state, :postal_code, :fax, :email, :corporate, :urn, :hours,
    :twitter_username, :facebook_username, :yelp_username, :pinterest_username,
    :foursquare_username, :tumblr_username, :instagram_username, :vimeo_username,
    :youtube_username, :domain, :phone_number)
  end
