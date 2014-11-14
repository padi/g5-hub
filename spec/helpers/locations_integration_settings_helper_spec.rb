require 'rails_helper'

describe LocationsIntegrationSettingsHelper do
  describe 'next_scheduled_run' do
    let(:created_at) { DateTime.new(2014, 6, 26) }
    let(:job) { G5::Jobbing::Job.new(created_at: created_at) }
    let(:locations_integration_setting) { Fabricate(:locations_integration_setting, current_job: job, integration_setting: Fabricate(:integration_setting, job_setting: job_setting)) }
    let(:job_setting) { Fabricate(:job_setting, frequency: 5, frequency_unit: FrequencyUnit.where(name: 'hours', minutes_multiplier: 60).first_or_create) }

    it 'calculates next scheduled run' do
      expect(helper.next_scheduled_run(locations_integration_setting)).to eq(created_at + 300.minutes)
    end

    it 'returns now if no current job' do
      expect(DateTime).to receive(:now).and_return(created_at)
      expect(helper.next_scheduled_run(Fabricate(:locations_integration_setting))).to eq(created_at)
    end
  end

  describe 'current_inventory_url' do
    let(:locations_integration_setting) { Fabricate(:locations_integration_setting, location: Fabricate(:location)) }

    before do
      allow(locations_integration_setting).to receive(:custom_value).with('inventory_service_url').and_return('http://example.com')
    end

    it 'builds the url' do
      expect(helper.current_inventory_url(locations_integration_setting)).to eq("http://example.com/#{locations_integration_setting.location.urn}/storage_units")
    end
  end
end