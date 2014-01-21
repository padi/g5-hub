class LocationDecorator < Draper::Decorator
  include HentryableDates

  delegate :name, :street_address_1, :street_address_2, :city, :state, :postal_code, :fax, :email, :urn, :corporate, :hours, :twitter_username, :facebook_username, :yelp_username, :pinterest_username, :foursquare_username, :tumblr_username, :instagram_username, :vimeo_username, :youtube_username, :domain
end
