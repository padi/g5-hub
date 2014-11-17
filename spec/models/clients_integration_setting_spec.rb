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

  describe :job_stat do
    it 'delegates error count to job stat' do
      job_stat = double(:job_stat, error_count: 3)
      expect(ClientsIntegrationSetting.new(job_stat: job_stat).job_stat_error_count).to eq(3)
    end

    it 'delegates error messages to job stat' do
      job_stat = double(:job_stat, error_messages: ['message'])
      expect(ClientsIntegrationSetting.new(job_stat: job_stat).job_stat_error_messages).to eq(['message'])
    end

    it 'allows nil' do
      expect(ClientsIntegrationSetting.new.job_stat_error_count).to be_nil
    end
  end
end