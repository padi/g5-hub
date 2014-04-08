class AddApartmentFeatures < ActiveRecord::Migration
  def change
    add_column :locations, :specific_demographic, :string
    add_column :locations, :primary_offering, :string
    add_column :locations, :secondary_other, :string
    add_column :locations, :secondary_condo, :boolean, default: false
    add_column :locations, :secondary_townhomes, :boolean, default: false
    add_column :locations, :secondary_apartments, :boolean, default: false
    add_column :locations, :floor_plans, :string
    add_column :locations, :university_landmark, :boolean, default: false
    add_column :locations, :employer_landmark, :boolean, default: false
    add_column :locations, :military_landmark, :boolean, default: false
    add_column :locations, :recreation_landmark, :boolean, default: false
    add_column :locations, :lake_landmark, :boolean, default: false
    add_column :locations, :hospital_landmark, :boolean, default: false
    add_column :locations, :furnished_property, :boolean, default: false
    add_column :locations, :gated_property, :boolean, default: false
    add_column :locations, :affordable_property, :boolean, default: false
    add_column :locations, :luxury_property, :boolean, default: false
    add_column :locations, :nearby_schools, :string
    add_column :locations, :highrise_structure, :boolean, default: false
    add_column :locations, :garden_structure, :boolean, default: false
    add_column :locations, :townhome_structure, :boolean, default: false
    add_column :locations, :modern_structure, :boolean, default: false
    add_column :locations, :nearby_employers, :string
    add_column :locations, :dogs_allowed, :boolean, default: false
    add_column :locations, :cats_allowed, :boolean, default: false
    add_column :locations, :accessibility, :string
    add_column :locations, :air_conditioned, :boolean, default: false
    add_column :locations, :cable_included, :boolean, default: false
    add_column :locations, :ceiling_fans, :boolean, default: false
    add_column :locations, :custom_cabinetry, :boolean, default: false
    add_column :locations, :dishwasher, :boolean, default: false
    add_column :locations, :energy_efficient, :boolean, default: false
    add_column :locations, :fireplace, :boolean, default: false
    add_column :locations, :granite_counters, :boolean, default: false
    add_column :locations, :hardwood_floors, :boolean, default: false
    add_column :locations, :private_balcony, :boolean, default: false
    add_column :locations, :private_patio, :boolean, default: false
    add_column :locations, :refrigerator, :boolean, default: false
    add_column :locations, :stainless_appliances, :boolean, default: false
    add_column :locations, :smoke_free, :boolean, default: false
    add_column :locations, :style_design, :string
    add_column :locations, :style_cost, :string
    add_column :locations, :walkin_closet, :boolean, default: false
    add_column :locations, :washer_dryer, :boolean, default: false
    add_column :locations, :has_view, :boolean, default: false
    add_column :locations, :other_amenities, :string
    add_column :locations, :carport_parking, :boolean, default: false
    add_column :locations, :club_house, :boolean, default: false
    add_column :locations, :dog_park, :boolean, default: false
    add_column :locations, :corporate_suites, :boolean, default: false
    add_column :locations, :family_friendly, :boolean, default: false
    add_column :locations, :fitness_center, :boolean, default: false
    add_column :locations, :furnished_apartments, :boolean, default: false
    add_column :locations, :garages, :boolean, default: false
    add_column :locations, :gated_entrance, :boolean, default: false
    add_column :locations, :laundry_facilities, :boolean, default: false
    add_column :locations, :online_rental_payments, :boolean, default: false
    add_column :locations, :onsite_management, :boolean, default: false
    add_column :locations, :close_park, :boolean, default: false
    add_column :locations, :pet_friendly, :boolean, default: false
    add_column :locations, :playground, :boolean, default: false
    add_column :locations, :recycling_center, :boolean, default: false
    add_column :locations, :swimming_pool, :boolean, default: false
    add_column :locations, :hot_tub, :boolean, default: false
    add_column :locations, :storage_available, :boolean, default: false
    add_column :locations, :tennis_court, :boolean, default: false
    add_column :locations, :wifi_available, :boolean, default: false
    add_column :locations, :other_community_amenities, :string
  end
end
