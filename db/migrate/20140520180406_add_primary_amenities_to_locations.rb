class AddPrimaryAmenitiesToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :apartment_amenity_1, :string
    add_column :locations, :apartment_amenity_2, :string
    add_column :locations, :community_amenity_1, :string
    add_column :locations, :community_amenity_2, :string
  end
end
