require 'spec_helper'

describe "Clients" do

  def create_client
    fill_in "client_name", with: "Housing Corp"
    fill_in "client_city", with: "Los Angeles"
    select "California", from: "client_state"
    select "Apartments", from: "client_vertical"
    select "MultiDomainClient", from: "client_domain_type"

    fill_in "client_street_address_1", with: "123 Sesame St"
    fill_in "client_email", with: "bigbird@gmail.com"

    fill_in "client_locations_attributes_0_name", with: "Oscar's Trash Can"
    fill_in "client_locations_attributes_0_domain", with: Faker::Internet.domain_name
    fill_in "client_locations_attributes_0_street_address_1", with: Faker::Address.street_address
    fill_in "client_locations_attributes_0_city", with: Faker::Address.city
    fill_in "client_locations_attributes_0_postal_code", with: Faker::Address.zip_code
    fill_in "client_locations_attributes_0_phone_number", with: Faker::PhoneNumber.phone_number
    fill_in "client_domain", with: "http://farmhouseapartments.com"

    select "California", from: "client_locations_attributes_0_state"

    click_button "Create Client"
  end


  describe "#index" do
    before do
      visit clients_path
    end

    it "has clients heading" do
      expect(page).to have_content "Clients"
    end

    it "shows all clients" do
      click_link "New Client"
      create_client
      expect(page).to have_content "Housing Corp"
      expect(page).to have_content "Apartments"
      expect(page).to have_content "MultiDomainClient"
      expect(page).to have_content "123 Sesame St"
      expect(page).to have_content "bigbird@gmail.com"
      expect(page).to have_content "http://farmhouseapartments.com"
    end
  end

  describe "#show" do
    before do
      visit clients_path
      click_link "New Client"
      create_client
      first(:link, "Housing Corp").click
    end

    it "has client heading" do
      expect(page).to have_content "Client"
    end

    it "shows client information" do
      expect(page).to have_content "Housing Corp"
      expect(page).to have_content "Apartments"
      expect(page).to have_content "MultiDomainClient"
      expect(page).to have_content "123 Sesame St"
      expect(page).to have_content "bigbird@gmail.com"
      expect(page).to have_content "http://farmhouseapartments.com"
    end

    describe "microformats2 parsing" do
      let(:document) { Microformats2.parse(page.source) }

      it "generates a valid Microformats2 document" do
        expect(document.cards.length).to eq(1)
      end
    end
  end

  describe "#new" do
    before do
      visit clients_path
      click_link "New Client"
    end

    it "has new client heading" do
      expect(page).to have_content "New Client"
    end

    it "can add a location" do
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

      expect(page).to have_content "Oscar's Trash Can"
    end
  end

end
