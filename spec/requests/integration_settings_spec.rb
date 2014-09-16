require 'spec_helper'

describe 'integration settings', auth_request: true do
  let(:client) { Fabricate(:client) }
  let(:location) { Fabricate(:location, client: client) }
  let(:integration_setting) { Fabricate(:integration_setting, location: location) }
  let!(:custom_integration_setting) { Fabricate(:custom_integration_setting, name: 'channel', value: 6, integration_setting: integration_setting) }

  describe :new do
    let(:inventory_service_url) { 'http://inventory-service.example.com' }
    let(:etl_strategy_name) { 'Centershift' }
    let(:vendor_endpoint) { 'http://centershift.example.com' }
    let(:vendor_user_name) { 'uname' }
    let(:vendor_password) { 'pw' }
    let(:custom_name) { 'custom name' }
    let(:custom_value) { 'custom value' }

    it 'creates integration settings' do
      visit new_location_integration_setting_path(location_id: location)
      fill_in 'integration_setting_inventory_service_url', with: inventory_service_url
      fill_in 'integration_setting_etl_strategy_name', with: etl_strategy_name
      fill_in 'integration_setting_vendor_endpoint', with: vendor_endpoint
      fill_in 'integration_setting_vendor_user_name', with: vendor_user_name
      fill_in 'integration_setting_vendor_password', with: vendor_password
      fill_in 'integration_setting_custom_integration_settings_attributes_0_name', with: custom_name
      fill_in 'integration_setting_custom_integration_settings_attributes_0_value', with: custom_value
      click_button 'Create Integration setting'

      expect(page).to have_content inventory_service_url
      expect(page).to have_content etl_strategy_name
      expect(page).to have_content vendor_endpoint
      expect(page).to have_content vendor_user_name
      expect(page).to have_content vendor_password
      expect(page).to have_content custom_name
      expect(page).to have_content custom_value
    end
  end

  describe :show do
    let(:document) { Microformats2.parse(page.source) }

    it 'generates a valid Microformats2 document with attributes' do
      visit client_location_path(client, location)
      expect(document.cards.length).to eq(1)
      expect(document.card.g5_inventory_service_url.to_s).to eq(integration_setting.inventory_service_url)
      expect(document.card.g5_etl_strategy_name.to_s).to eq(integration_setting.etl_strategy_name)
      expect(document.card.g5_vendor_endpoint.to_s).to eq(integration_setting.vendor_endpoint)
      expect(document.card.g5_vendor_user_name.to_s).to eq(integration_setting.vendor_user_name)
      expect(document.card.g5_vendor_password.to_s).to eq(integration_setting.vendor_password)
      expect(document.card.g5_custom_integration_setting_name_0.to_s).to eq('channel')
      expect(document.card.g5_custom_integration_setting_value_0.to_s).to eq(custom_integration_setting.value.to_s)
    end
  end
end