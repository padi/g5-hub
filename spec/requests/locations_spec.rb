require 'spec_helper'

describe "Locations" do

  def new_client
    visit clients_path
    click_link "New Client"
    fill_in "client_name", with: "Housing Corp"
    fill_in "client_city", with: "Los Angeles"
    select "California", from: "client_state"
    select "Apartments", from: "client_vertical"

    fill_in "client_locations_attributes_0_name", with: "Oscar's Trash Can"
    fill_in "client_locations_attributes_0_domain", with: Faker::Internet.domain_name
    fill_in "client_locations_attributes_0_street_address_1", with: Faker::Address.street_address
    fill_in "client_locations_attributes_0_city", with: Faker::Address.city
    fill_in "client_locations_attributes_0_state", with: Faker::Address.state
    fill_in "client_locations_attributes_0_postal_code", with: Faker::Address.zip_code
    fill_in "client_locations_attributes_0_phone_number", with: Faker::PhoneNumber.phone_number
  end

  describe "new" do
    it "can create a location with hours" do
      new_client
      fill_in "client_locations_attributes_0_hours", with: "Mon-Fri: 5-8"
      click_button "Create Client"
      expect(page).to have_content "Oscar's Trash Can"
      click_link "Oscar's Trash Can"
      expect(page).to have_content "Mon-Fri: 5-8"
    end

    it "can create a location with social site usernames" do
      new_client
      fill_in "client_locations_attributes_0_twitter_username", with: "BigBird"
      click_button "Create Client"
      click_link "Oscar's Trash Can"
      expect(page).to have_content "BigBird"
    end

    it "can create a location with a domain" do
      new_client
      fill_in "client_locations_attributes_0_domain", with: "http://www.oscarstrashcan.com/"
      click_button "Create Client"
      click_link "Oscar's Trash Can"
      expect(page).to have_content "http://www.oscarstrashcan.com/"
    end
  end
end
