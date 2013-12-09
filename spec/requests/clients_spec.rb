require 'spec_helper'

describe "Clients" do
  
  def create_client
    fill_in "client_name", with: "Housing Corp"
    select "Apartments", from: "client_vertical"
    fill_in "client_street_address_1", with: "123 Sesame St"
    fill_in "client_email", with: "bigbird@gmail.com"
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
      expect(page).to have_content "123 Sesame St"
      expect(page).to have_content "bigbird@gmail.com"
    end
  end
  
  describe "#show" do
    before do
      visit clients_path
      click_link "New Client"
      create_client
      click_link "Housing Corp"
    end
    
    it "has client heading" do
      expect(page).to have_content "Client"
    end
    
    it "shows client information" do
      expect(page).to have_content "Housing Corp"
      expect(page).to have_content "Apartments"
      expect(page).to have_content "123 Sesame St"
      expect(page).to have_content "bigbird@gmail.com"
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
      select "Apartments", from: "client_vertical"
      fill_in "client_locations_attributes_0_name", with: "Oscar's Trash Can"
      click_button "Create Client"
      expect(page).to have_content "Oscar's Trash Can"
    end
  end
  
end