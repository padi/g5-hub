class ClientsController < ApplicationController
  DEMOGRAPHIC_OPTIONS = ['Senior Apartments', 'Student Housing']

  def index
    client_scope = Client.order("updated_at DESC")
    @clients = ClientDecorator.decorate_collection(client_scope)
  end

  def show
    @client = Client.find_by_urn!(params[:id]).decorate
  end

  def new
    @client = Client.new
    @client.locations.build
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to client_url(@client), :notice => "Successfully created client."
    else
      @client.locations.build if @client.locations.blank?
      render :action => 'new'
    end
  end

  def edit
    @client = Client.find_by_urn(params[:id])
    @client.locations.build if @client.locations.blank?
  end

  def update
    @client = Client.find_by_urn(params[:id])
    if @client.update_attributes(client_params)
      redirect_to client_url, :notice  => "Successfully updated client."
    else
      @client.locations.build if @client.locations.blank?
      render :action => 'edit'
    end
  end

  def destroy
    @client = Client.find_by_urn(params[:id])
    @client.destroy
    redirect_to clients_url, :notice => "Successfully destroyed client."
  end

private

  def client_params
    params.fetch(:client, {}).permit(:name, :street_address_1, :street_address_2,
    :city, :state, :postal_code, :tel, :fax, :email, :vertical, :urn, :domain_type,
    locations_attributes: [LOCATION_PARAMS])
  end

  LOCATION_PARAMS = :id, :name, :street_address_1, :street_address_2,
  :city, :state, :postal_code, :fax, :email, :corporate,
  :urn, :hours, :twitter_username, :facebook_username, :yelp_username,
  :pinterest_username, :foursquare_username, :tumblr_username,
  :instagram_username, :vimeo_username, :youtube_username, :domain, :phone_number,
  :neighborhood, :rv_storage, :boat_storage, :business_storage, :other_storage,
  :gate_access, :security_monitoring, :business_center, :climate_controlled,
  :heated_cooled, :friendly_staff, :covered_drivethru, :covered_loading,
  :rv_boat_storage, :outside_parking, :seven_day_access, :deliveries,
  :dollies_carts, :digital_surveillance, :drive_up_access, :electronic_gate,
  :uhaul_trucks, :budget_trucks, :moving_trucks, :free_truck, :fenced_lighted,
  :ground_level_units, :high_ceilings, :individual_alarmed_units, :mail_boxes,
  :major_credit_cards, :military_discounts, :student_discount, :senior_discount,
  :month_to_month, :no_admin_fee, :no_deposits, :no_late_fees, :online_bill_pay,
  :packing_moving_supplies, :boxes_locks, :tenant_insurance, :truck_rentals,
  :wide_driveways, :wine_storage, :other_features, :specific_demographic,
  :primary_offering, :secondary_other, :secondary_condo, :secondary_townhomes,
  :secondary_apartments, :floor_plans, :university_landmark, :employer_landmark,
  :military_landmark, :recreation_landmark, :lake_landmark, :hospital_landmark,
  :furnished_property, :gated_property, :affordable_property, :luxury_property,
  :nearby_schools, :highrise_structure, :garden_structure, :townhome_structure,
  :modern_structure, :nearby_employers, :dogs_allowed, :cats_allowed, :accessibility,
  :air_conditioned, :cable_included, :ceiling_fans, :custom_cabinetry, :dishwasher,
  :energy_efficient, :fireplace, :granite_counters, :hardwood_floors,
  :private_balcony, :private_patio, :refrigerator, :stainless_appliances,
  :smoke_free, :style_design, :style_cost, :walkin_closet, :washer_dryer,
  :has_view, :other_amenities, :carport_parking, :club_house, :dog_park,
  :corporate_suites, :family_friendly, :fitness_center, :furnished_apartments,
  :garages, :gated_entrance, :laundry_facilities, :online_rental_payments,
  :onsite_management, :close_park, :pet_friendly, :playground, :recycling_center,
  :swimming_pool, :hot_tub, :storage_available, :tennis_court, :wifi_available,
  :other_community_amenities, :ga_tracking_id, :ga_profile_id
end
