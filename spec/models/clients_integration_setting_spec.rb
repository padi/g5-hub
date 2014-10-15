require 'rails_helper'

describe ClientsIntegrationSetting do
  it { is_expected.to have_many :locations_integration_settings }
  it { is_expected.to have_many(:locations).through(:locations_integration_settings) }
  it { is_expected.to belong_to :client }
  it { is_expected.to belong_to :vendor }
  it { is_expected.to belong_to :integration_setting }
  it { is_expected.to validate_inclusion_of(:vendor_action).in_array(ClientsIntegrationSetting::VENDOR_ACTIONS) }
  it { is_expected.to accept_nested_attributes_for(:integration_setting) }
end