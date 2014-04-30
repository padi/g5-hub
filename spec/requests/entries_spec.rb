require 'spec_helper'

describe "Entries" do

  def create_client
    fill_in "client_name", with: "Housing Corp"
    fill_in "client_city", with: "Los Angeles"
    select "California", from: "client_state"
    select "Apartments", from: "client_vertical"
    select "MultiDomainClient", from: "client_domain_type"

    fill_in "client_locations_attributes_0_name", with: "Oscar's Trash Can"
    fill_in "client_locations_attributes_0_domain", with: Faker::Internet.domain_name
    fill_in "client_locations_attributes_0_street_address_1", with: Faker::Address.street_address
    fill_in "client_locations_attributes_0_city", with: Faker::Address.city
    fill_in "client_locations_attributes_0_state", with: Faker::Address.state
    fill_in "client_locations_attributes_0_postal_code", with: Faker::Address.zip_code
    fill_in "client_locations_attributes_0_phone_number", with: Faker::PhoneNumber.phone_number

    click_button "Create Client"
  end

  describe "#index" do
    it "has Entry title" do
      visit entries_path
      expect(page).to have_content "Entries"
    end

    it "shows new client" do
      visit clients_path
      click_link "New Client"
      create_client
      click_link "Entries"
      expect(page).to have_content "Housing Corp"
      expect(page).to have_content "Apartments"
      expect(page).to have_content "MultiDomainClient"
      expect(page).to have_content "Oscar's Trash Can"
    end
  end

end
