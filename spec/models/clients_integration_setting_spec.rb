require 'rails_helper'

describe ClientsIntegrationSetting do
  it { is_expected.to have_many :locations_integration_settings }
  it { is_expected.to have_many(:locations).through(:locations_integration_settings) }
  it { is_expected.to belong_to :client }
  it { is_expected.to belong_to :vendor }
  it { is_expected.to belong_to :integration_setting }
  it { is_expected.to validate_inclusion_of(:vendor_action).in_array(ClientsIntegrationSetting::VENDOR_ACTIONS) }
  it { is_expected.to accept_nested_attributes_for(:integration_setting) }

  describe :inventory? do
    specify { expect(ClientsIntegrationSetting.new(vendor_action: ClientsIntegrationSetting::INVENTORY_VENDOR_ACTION).inventory?).to be_truthy }
    specify { expect(ClientsIntegrationSetting.new(vendor_action: ClientsIntegrationSetting::LEAD_VENDOR_ACTION).inventory?).to be_falsey }
  end
end