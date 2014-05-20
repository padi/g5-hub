class LocationDecorator < Draper::Decorator
  include HentryableDates

  delegate :name, :street_address_1, :street_address_2, :city, :state,
  :postal_code, :fax, :email, :urn, :corporate, :hours, :twitter_username,
  :facebook_username, :yelp_username, :pinterest_username,
  :foursquare_username, :tumblr_username, :instagram_username, :vimeo_username,
  :youtube_username, :domain, :phone_number, :ga_tracking_id, :ga_profile_id,
  :neighborhood, :floor_plans, :landmark_1_type, :landmark_1_name, :landmark_2_type,
  :landmark_2_name, :property_feature_1, :property_feature_2, :property_feature_3,
  :apartment_amenity_1, :apartment_amenity_2, :community_amenity_1, :community_amenity_2
end
