class AddSocialLinksToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :twitter_username, :string
    add_column :locations, :facebook_username, :string
    add_column :locations, :yelp_username, :string
    add_column :locations, :pinterest_username, :string
    add_column :locations, :foursquare_username, :string
    add_column :locations, :tumblr_username, :string
    add_column :locations, :instagram_username, :string
    add_column :locations, :vimeo_username, :string
    add_column :locations, :youtube_username, :string
  end
end
