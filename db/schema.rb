# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141030222429) do

  create_table "clients", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "urn"
    t.string   "vertical"
    t.string   "street_address_1"
    t.string   "street_address_2"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "fax"
    t.string   "email"
    t.string   "tel"
    t.string   "domain_type"
    t.string   "domain"
    t.string   "organization"
  end

  create_table "clients_integration_settings", force: true do |t|
    t.integer "vendor_id"
    t.string  "vendor_action"
    t.integer "client_id"
    t.integer "integration_setting_id"
  end

  add_index "clients_integration_settings", ["client_id"], name: "index_cis_on_client"
  add_index "clients_integration_settings", ["vendor_id", "client_id", "vendor_action"], name: "index_cis_on_vendor_and_client_and_action"

  create_table "custom_integration_settings", force: true do |t|
    t.integer  "integration_setting_id"
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "custom_integration_settings", ["integration_setting_id"], name: "index_custom_integration_settings_on_integration_setting_id"

  create_table "frequency_units", force: true do |t|
    t.string   "name"
    t.integer  "minutes_multiplier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "g5_authenticatable_users", force: true do |t|
    t.string   "email",              default: "",   null: false
    t.string   "provider",           default: "g5", null: false
    t.string   "uid",                               null: false
    t.string   "g5_access_token"
    t.integer  "sign_in_count",      default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "g5_authenticatable_users", ["email"], name: "index_g5_authenticatable_users_on_email", unique: true
  add_index "g5_authenticatable_users", ["provider", "uid"], name: "index_g5_authenticatable_users_on_provider_and_uid", unique: true

  create_table "integration_settings", force: true do |t|
    t.string   "strategy_name"
    t.string   "vendor_user_name"
    t.string   "vendor_password"
    t.string   "vendor_endpoint"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_settings", force: true do |t|
    t.integer  "integration_setting_id"
    t.integer  "frequency_unit_id"
    t.integer  "frequency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "job_settings", ["integration_setting_id"], name: "index_job_settings_on_integration_setting_id"

  create_table "locations", force: true do |t|
    t.integer  "client_id"
    t.string   "name"
    t.boolean  "corporate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "urn"
    t.string   "street_address_1"
    t.string   "street_address_2"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "fax"
    t.string   "email"
    t.string   "hours"
    t.string   "twitter_username"
    t.string   "facebook_username"
    t.string   "yelp_username"
    t.string   "pinterest_username"
    t.string   "foursquare_username"
    t.string   "tumblr_username"
    t.string   "instagram_username"
    t.string   "vimeo_username"
    t.string   "youtube_username"
    t.string   "domain"
    t.string   "phone_number"
    t.string   "neighborhood"
    t.boolean  "boat_storage",              default: false
    t.boolean  "business_storage",          default: false
    t.boolean  "gate_access",               default: false
    t.boolean  "security_monitoring",       default: false
    t.boolean  "business_center",           default: false
    t.boolean  "climate_controlled",        default: false
    t.boolean  "heated_cooled",             default: false
    t.boolean  "friendly_staff",            default: false
    t.boolean  "covered_drivethru",         default: false
    t.boolean  "covered_loading",           default: false
    t.boolean  "rv_boat_storage",           default: false
    t.boolean  "outside_parking",           default: false
    t.boolean  "deliveries",                default: false
    t.boolean  "dollies_carts",             default: false
    t.boolean  "digital_surveillance",      default: false
    t.boolean  "drive_up_access",           default: false
    t.boolean  "electronic_gate",           default: false
    t.boolean  "uhaul_trucks",              default: false
    t.boolean  "budget_trucks",             default: false
    t.boolean  "moving_trucks",             default: false
    t.boolean  "free_truck",                default: false
    t.boolean  "fenced_lighted",            default: false
    t.boolean  "ground_level_units",        default: false
    t.boolean  "high_ceilings",             default: false
    t.boolean  "individual_alarmed_units",  default: false
    t.boolean  "mail_boxes",                default: false
    t.boolean  "major_credit_cards",        default: false
    t.boolean  "military_discounts",        default: false
    t.boolean  "student_discount",          default: false
    t.boolean  "senior_discount",           default: false
    t.boolean  "month_to_month",            default: false
    t.boolean  "no_admin_fee",              default: false
    t.boolean  "no_deposits",               default: false
    t.boolean  "no_late_fees",              default: false
    t.boolean  "online_bill_pay",           default: false
    t.boolean  "packing_moving_supplies",   default: false
    t.boolean  "boxes_locks",               default: false
    t.boolean  "tenant_insurance",          default: false
    t.boolean  "truck_rentals",             default: false
    t.boolean  "wide_driveways",            default: false
    t.boolean  "wine_storage",              default: false
    t.string   "other_features"
    t.boolean  "rv_storage",                default: false
    t.boolean  "seven_day_access",          default: false
    t.string   "other_storage"
    t.string   "specific_demographic"
    t.string   "primary_offering"
    t.string   "secondary_other"
    t.boolean  "secondary_condo",           default: false
    t.boolean  "secondary_townhomes",       default: false
    t.boolean  "secondary_apartments",      default: false
    t.string   "floor_plans"
    t.string   "nearby_schools"
    t.boolean  "highrise_structure",        default: false
    t.boolean  "garden_structure",          default: false
    t.boolean  "townhome_structure",        default: false
    t.boolean  "modern_structure",          default: false
    t.string   "nearby_employers"
    t.boolean  "dogs_allowed",              default: false
    t.boolean  "cats_allowed",              default: false
    t.string   "accessibility"
    t.boolean  "air_conditioned",           default: false
    t.boolean  "cable_included",            default: false
    t.boolean  "ceiling_fans",              default: false
    t.boolean  "custom_cabinetry",          default: false
    t.boolean  "dishwasher",                default: false
    t.boolean  "energy_efficient",          default: false
    t.boolean  "fireplace",                 default: false
    t.boolean  "granite_counters",          default: false
    t.boolean  "hardwood_floors",           default: false
    t.boolean  "private_balcony",           default: false
    t.boolean  "private_patio",             default: false
    t.boolean  "refrigerator",              default: false
    t.boolean  "stainless_appliances",      default: false
    t.boolean  "smoke_free",                default: false
    t.string   "style_design"
    t.string   "style_cost"
    t.boolean  "walkin_closet",             default: false
    t.boolean  "washer_dryer",              default: false
    t.boolean  "has_view",                  default: false
    t.string   "other_amenities"
    t.boolean  "carport_parking",           default: false
    t.boolean  "club_house",                default: false
    t.boolean  "dog_park",                  default: false
    t.boolean  "corporate_suites",          default: false
    t.boolean  "family_friendly",           default: false
    t.boolean  "fitness_center",            default: false
    t.boolean  "furnished_apartments",      default: false
    t.boolean  "garages",                   default: false
    t.boolean  "gated_entrance",            default: false
    t.boolean  "laundry_facilities",        default: false
    t.boolean  "online_rental_payments",    default: false
    t.boolean  "onsite_management",         default: false
    t.boolean  "close_park",                default: false
    t.boolean  "pet_friendly",              default: false
    t.boolean  "playground",                default: false
    t.boolean  "recycling_center",          default: false
    t.boolean  "swimming_pool",             default: false
    t.boolean  "hot_tub",                   default: false
    t.boolean  "storage_available",         default: false
    t.boolean  "tennis_court",              default: false
    t.boolean  "wifi_available",            default: false
    t.string   "other_community_amenities"
    t.string   "primary_offering_other"
    t.string   "ga_tracking_id"
    t.string   "ga_profile_id"
    t.string   "landmark_1_type"
    t.string   "landmark_1_name"
    t.string   "landmark_2_type"
    t.string   "landmark_2_name"
    t.string   "property_feature_1"
    t.string   "property_feature_2"
    t.string   "property_feature_3"
    t.string   "apartment_amenity_1"
    t.string   "apartment_amenity_2"
    t.string   "community_amenity_1"
    t.string   "community_amenity_2"
    t.string   "status",                    default: "Pending"
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_content_type"
    t.integer  "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "locations_integration_settings", force: true do |t|
    t.integer  "clients_integration_setting_id"
    t.integer  "location_id"
    t.integer  "integration_setting_id"
    t.string   "urn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations_integration_settings", ["location_id", "clients_integration_setting_id"], name: "index_lis_on_location_and_client_int", unique: true
  add_index "locations_integration_settings", ["location_id"], name: "index_lis_on_location"

  create_table "vendors", force: true do |t|
    t.string "name"
  end

end
