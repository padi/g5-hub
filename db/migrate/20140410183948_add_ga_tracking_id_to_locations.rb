class AddGaTrackingIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :ga_tracking_id, :string
    add_column :locations, :ga_profile_id, :string
  end
end
