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

ActiveRecord::Schema.define(version: 20140407213924) do

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
  end

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
    t.boolean  "boat_storage",             default: false
    t.boolean  "business_storage",         default: false
    t.boolean  "other_storage",            default: false
    t.boolean  "gate_access",              default: false
    t.boolean  "security_monitoring",      default: false
    t.boolean  "business_center",          default: false
    t.boolean  "climate_controlled",       default: false
    t.boolean  "heated_cooled",            default: false
    t.boolean  "friendly_staff",           default: false
    t.boolean  "covered_drivethru",        default: false
    t.boolean  "covered_loading",          default: false
    t.boolean  "rv_boat_storage",          default: false
    t.boolean  "outside_parking",          default: false
    t.boolean  "deliveries",               default: false
    t.boolean  "dollies_carts",            default: false
    t.boolean  "digital_surveillance",     default: false
    t.boolean  "drive_up_access",          default: false
    t.boolean  "electronic_gate",          default: false
    t.boolean  "uhaul_trucks",             default: false
    t.boolean  "budget_trucks",            default: false
    t.boolean  "moving_trucks",            default: false
    t.boolean  "free_truck",               default: false
    t.boolean  "fenced_lighted",           default: false
    t.boolean  "ground_level_units",       default: false
    t.boolean  "high_ceilings",            default: false
    t.boolean  "individual_alarmed_units", default: false
    t.boolean  "mail_boxes",               default: false
    t.boolean  "major_credit_cards",       default: false
    t.boolean  "military_discounts",       default: false
    t.boolean  "student_discount",         default: false
    t.boolean  "senior_discount",          default: false
    t.boolean  "month_to_month",           default: false
    t.boolean  "no_admin_fee",             default: false
    t.boolean  "no_deposits",              default: false
    t.boolean  "no_late_fees",             default: false
    t.boolean  "online_bill_pay",          default: false
    t.boolean  "packing_moving_supplies",  default: false
    t.boolean  "boxes_locks",              default: false
    t.boolean  "tenant_insurance",         default: false
    t.boolean  "truck_rentals",            default: false
    t.boolean  "wide_driveways",           default: false
    t.boolean  "wine_storage",             default: false
    t.string   "other_features"
  end

end
