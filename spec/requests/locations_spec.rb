require 'spec_helper'

describe "Locations", auth_request: true do

  def new_client
    visit clients_path
    click_link "New Client"
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
    it "can create an Apartment location with a specific demographic" do
      new_client
      select "Senior Apartments", from: "client_locations_attributes_0_specific_demographic"
      click_button "Create Client"
      click_link "Edit Client"
      expect(find(:css, '#client_locations_attributes_0_specific_demographic').value).to eq("Senior Apartments")
    end
    it "can create a Self-Storage location with a specific service" do
      new_client
      select "Self-Storage", from: "client_vertical"
      check('client_locations_attributes_0_rv_storage')
      click_button "Create Client"
      click_link "Edit Client"
      expect(find(:css, '#client_vertical').value).to eq("Self-Storage")
      expect(find(:css, '#client_locations_attributes_0_rv_storage')).to be_checked
    end
    it "can create a location with an analytics tracking ID" do
      new_client
      fill_in "client_locations_attributes_0_ga_tracking_id", with: "UA-1234-56"
      fill_in "client_locations_attributes_0_ga_profile_id", with: "ga:12345678"
      click_button "Create Client"
      click_link "Oscar's Trash Can"
      expect(page).to have_content "UA-1234-56"
      expect(page).to have_content "ga:12345678"
    end
    describe "the correct fields show when a client vertical is chosen", js: true do
      it "cannot see extra fields on first page load" do
        visit clients_path
        click_link "New Client"
        within('#locations_container') do
          expect(page).to_not have_content('Services and Features')
          expect(page).to_not have_content('Amenities')
        end
      end
      it "can see apartments fields when apartment vertical is chosen" do
        visit clients_path
        click_link "New Client"
        select "Apartments", from: "client_vertical"
        expect(page).to have_selector('#apartments-fields', visible: true)
        expect(page).to_not have_selector('#self-storage-fields', visible: true)

        select "Self-Storage", from: "client_vertical"
        expect(page).to have_selector('#self-storage-fields', visible: true)
        expect(page).to_not have_selector('#apartments-fields', visible: true)
      end
    end
  end

  describe "show" do
    let(:client) { Fabricate(:client) }
    let(:location) do
      Fabricate(
        :location,
        client: client,
        ga_profile_id: "profile",
        ga_tracking_id: "tracking"
      )
    end
    let(:document) { Microformats2.parse(page.source) }

    it "generates a valid Microformats2 document with attributes" do
      visit client_location_path(client, location)
      expect(document.cards.length).to eq(1)
      expect(document.card.uid.to_s).to match(client_location_path(client, location))
      expect(document.card.name.to_s).to eq(location.name)
      expect(document.card.adr.format.tel.to_s).to eq(location.phone_number)
      expect(document.card.ga_tracking_id.to_s).to eq(location.ga_tracking_id)
      expect(document.card.ga_profile_id.to_s).to eq(location.ga_profile_id)
    end

    context "when the location has blank hours" do
      before { location.update_attributes!(hours: "") }

      it "does not explode" do
        visit client_location_path(client, location)
        expect { document }.to_not raise_error
      end
    end
  end
end
