require 'spec_helper'

describe "Locations" do
  
  def new_client
    visit clients_path
    click_link "New Client"
    fill_in "client_name", with: "Housing Corp"
    select "Apartments", from: "client_vertical"
    fill_in "client_locations_attributes_0_name", with: "Oscar's Trash Can"
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
  end
end