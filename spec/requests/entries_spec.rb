require 'spec_helper'

describe "Entries" do
  
  def create_client
    fill_in "client_name", with: "Housing Corp"
    select "Apartments", from: "client_vertical"
    fill_in "client_city", with: "Los Angeles"
    select "California", from: "client_state"
    fill_in "client_locations_attributes_0_name", with: "Oscar's Trash Can"
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
      expect(page).to have_content "Oscar's Trash Can"
    end
  end
  
end