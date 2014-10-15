require 'rails_helper'

describe LocationsIntegrationSettingSerializer do
  let(:clients_integration_setting) { Fabricate(:clients_integration_setting) }
  let(:serializer) { LocationsIntegrationSettingSerializer.new(locations_integration_setting) }
  subject { indifferent_hash(serializer.to_json)[:locations_integration_setting] }

  context 'no location integration settings so we use client integration settings as is' do
    let!(:custom_integration_setting) { integration_setting.custom_integration_settings.create(name: 'foo', value: 'bar') }
    let(:integration_setting) { clients_integration_setting.integration_setting }
    let(:locations_integration_setting) { Fabricate(:locations_integration_setting, clients_integration_setting: clients_integration_setting, integration_setting: nil) }

    its([:strategy_name]) { is_expected.to eq(integration_setting.strategy_name) }
    its([:vendor_endpoint]) { is_expected.to eq(integration_setting.vendor_endpoint) }
    its([:vendor_user_name]) { is_expected.to eq(integration_setting.vendor_user_name) }
    its([:vendor_password]) { is_expected.to eq(integration_setting.vendor_password) }
    its([:vendor_action]) { is_expected.to eq(clients_integration_setting.vendor_action) }
    its([:vendor]) { is_expected.to eq(clients_integration_setting.vendor.name) }
    its([:foo]) { is_expected.to eq('bar') }
  end

  context 'has location integration settings so we merge into client integration settings' do
    let(:custom_integration_setting) { integration_setting.custom_integration_settings.create(name: 'foo', value: 'bar') }
    let(:client_integration_setting) { clients_integration_setting.integration_setting }
    let(:locations_integration_setting) { Fabricate(:locations_integration_setting, clients_integration_setting: clients_integration_setting, integration_setting: IntegrationSetting.new(override: true, strategy_name: 'overridden strategy name')) }
    let!(:custom_integration_setting_1) { locations_integration_setting.integration_setting.custom_integration_settings.create(name: 'foo', value: 'baz') }
    let!(:custom_integration_setting_2) { locations_integration_setting.integration_setting.custom_integration_settings.create(name: 'joe', value: 'bob') }

    its([:strategy_name]) { is_expected.to eq('overridden strategy name') }
    its([:vendor_endpoint]) { is_expected.to eq(client_integration_setting.vendor_endpoint) }
    its([:vendor_user_name]) { is_expected.to eq(client_integration_setting.vendor_user_name) }
    its([:vendor_password]) { is_expected.to eq(client_integration_setting.vendor_password) }
    its([:vendor_action]) { is_expected.to eq(clients_integration_setting.vendor_action) }
    its([:vendor]) { is_expected.to eq(clients_integration_setting.vendor.name) }
    its([:foo]) { is_expected.to eq('baz') }
    its([:joe]) { is_expected.to eq('bob') }
  end
end