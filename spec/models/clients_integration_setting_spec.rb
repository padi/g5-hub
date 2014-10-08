require 'spec_helper'

describe ClientsIntegrationSetting do
  it { should have_many :locations_integration_settings }
  it { should have_many(:locations).through(:locations_integration_settings) }
  it { should belong_to :client }
  it { should belong_to :vendor }
  it { should belong_to :integration_setting }
  it { should validate_inclusion_of(:vendor_action).in_array(ClientsIntegrationSetting::VENDOR_ACTIONS) }
  it { should accept_nested_attributes_for(:integration_setting) }
end