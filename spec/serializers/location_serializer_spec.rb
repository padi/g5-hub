require 'rails_helper'

describe LocationSerializer do
  let(:location) { Fabricate(:location, client: Fabricate(:client), locations_integration_settings: [locations_integration_setting]) }
  let(:locations_integration_setting) { Fabricate(:locations_integration_setting) }
  let(:serializer) { LocationSerializer.new(location) }
  subject { indifferent_hash(serializer.to_json)[:location] }

  SERIALIZED_ATTRIBUTES = [:id, :client_id, :name, :corporate, :urn,
                           :street_address_1, :street_address_2, :city, :state, :postal_code,
                           :fax, :email, :hours, :twitter_username, :facebook_username, :yelp_username,
                           :pinterest_username, :foursquare_username, :tumblr_username, :instagram_username,
                           :vimeo_username, :youtube_username, :domain, :phone_number, :neighborhood, :boat_storage,
                           :business_storage, :gate_access, :security_monitoring, :business_center, :climate_controlled,
                           :heated_cooled, :friendly_staff, :covered_drivethru, :covered_loading, :rv_boat_storage,
                           :outside_parking, :deliveries, :dollies_carts, :digital_surveillance, :drive_up_access,
                           :electronic_gate, :uhaul_trucks, :budget_trucks, :moving_trucks, :free_truck, :fenced_lighted,
                           :ground_level_units, :high_ceilings, :individual_alarmed_units, :mail_boxes, :major_credit_cards,
                           :military_discounts, :student_discount, :senior_discount, :month_to_month, :no_admin_fee, :no_deposits,
                           :no_late_fees, :online_bill_pay, :packing_moving_supplies, :boxes_locks, :tenant_insurance, :truck_rentals,
                           :wide_driveways, :wine_storage, :other_features, :rv_storage, :seven_day_access, :other_storage,
                           :specific_demographic, :primary_offering, :secondary_other, :secondary_condo, :secondary_townhomes, :secondary_apartments, :floor_plans,
                           :nearby_schools, :highrise_structure, :garden_structure, :townhome_structure, :modern_structure, :nearby_employers, :dogs_allowed,
                           :cats_allowed, :accessibility, :air_conditioned, :cable_included, :ceiling_fans, :custom_cabinetry, :dishwasher,
                           :energy_efficient, :fireplace, :granite_counters, :hardwood_floors, :private_balcony, :private_patio, :refrigerator,
                           :stainless_appliances, :smoke_free, :style_design, :style_cost, :walkin_closet, :washer_dryer, :has_view, :other_amenities,
                           :carport_parking, :club_house, :dog_park, :corporate_suites, :family_friendly, :fitness_center, :furnished_apartments, :garages,
                           :gated_entrance, :laundry_facilities, :online_rental_payments, :onsite_management, :close_park, :pet_friendly, :playground,
                           :recycling_center, :swimming_pool, :hot_tub, :storage_available, :tennis_court, :wifi_available, :other_community_amenities,
                           :primary_offering_other, :ga_tracking_id, :ga_profile_id, :landmark_1_type, :landmark_1_name, :landmark_2_type, :landmark_2_name,
                           :property_feature_1, :property_feature_2, :property_feature_3, :apartment_amenity_1, :apartment_amenity_2,
                           :community_amenity_1, :community_amenity_2]

  SERIALIZED_ATTRIBUTES.each do |field|

    its([field]) { is_expected.to eq(location.send(field)) }
  end

  its([:locations_integration_settings]) { is_expected.to_not be_empty }
  its([:uid]) { eq("http://#{ENV['HOST']}/clients/#{location.client.urn}/locations#{location.urn}") }
  its([:client_uid]) { eq("http://#{ENV['HOST']}/clients/#{location.client.urn}") }
end