require 'spec_helper'

describe "Entries", auth_request: true do

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
    fill_in "client_locations_attributes_0_postal_code", with: Faker::Address.zip_code
    fill_in "client_locations_attributes_0_phone_number", with: Faker::PhoneNumber.phone_number

    select "California", from: "client_locations_attributes_0_state"

    click_button "Create Client"
  end

  describe "#index", auth_request: true do
    it "has Entry title" do
      visit entries_path
      expect(page).to have_content "Entries"
    end
  end

  describe "#show" do
    let!(:client) { Fabricate(:client) }

    it "shows a client with no authorization  client" do
      visit client_path(client)

      expect(page).to have_content client.name
      expect(page).to have_content client.vertical
      expect(page).to have_content client.city
      expect(page).to have_content client.state
    end
  end
end
