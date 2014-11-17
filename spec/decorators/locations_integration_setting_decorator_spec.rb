require 'rails_helper'

describe LocationsIntegrationSettingDecorator do
  let(:job_setting) { Fabricate(:job_setting) }
  let(:integration_setting) { Fabricate(:integration_setting, job_setting: job_setting) }
  let(:locations_integration_setting) { Fabricate(:locations_integration_setting, location: Fabricate(:location), integration_setting: integration_setting) }
  subject { locations_integration_setting.decorate }

  describe 'frequency' do
    context 'with plural frequency' do
      its(:frequency) { is_expected.to eq('3 minutes') }
    end

    context 'with singular frequency' do
      let(:job_setting) { Fabricate(:job_setting, frequency: 1) }
      its(:frequency) { is_expected.to eq('1 minute') }
    end

    context 'with no frequency' do
      let(:integration_setting) { Fabricate(:integration_setting) }
      its(:frequency) { is_expected.to be_nil }
    end
  end

  describe 'next_scheduled_run' do
    let(:created_at) { DateTime.new(2014, 6, 26) }
    let(:job) { G5::Jobbing::Job.new(created_at: created_at) }
    let(:locations_integration_setting) { Fabricate(:locations_integration_setting, current_job: job, integration_setting: Fabricate(:integration_setting, job_setting: job_setting)) }
    let(:job_setting) { Fabricate(:job_setting, frequency: 5, frequency_unit: FrequencyUnit.where(name: 'hours', minutes_multiplier: 60).first_or_create) }

    it 'calculates next scheduled run' do
      expect(subject.next_scheduled_run).to eq((created_at + 300.minutes).to_s(:human))
    end

    context 'no current job' do
      before do
        locations_integration_setting.current_job = nil
        expect(DateTime).to receive(:now).and_return(created_at)
      end
      it 'returns now if no current job' do
        expect(subject.next_scheduled_run).to eq(created_at)
      end
    end
  end


  describe 'current_inventory_url' do
    before do
      allow(locations_integration_setting).to receive(:custom_value).with('inventory_service_url').and_return('http://example.com')
    end

    its(:current_inventory_url) { is_expected.to eq("http://example.com/#{locations_integration_setting.location.urn}/storage_units") }
  end

  describe 'current_job_state_class' do
    context 'with error' do
      before { locations_integration_setting.current_job = G5::Jobbing::Job.new(error_state: true) }
      its(:current_job_state_class) { is_expected.to eq('job-error') }
    end

    context 'with success' do
      before { locations_integration_setting.current_job = G5::Jobbing::Job.new(error_state: false, success_state: true) }
      its(:current_job_state_class) { is_expected.to eq('job-success') }
    end

    context 'in progress' do
      before { locations_integration_setting.current_job = G5::Jobbing::Job.new(error_state: false, success_state: false) }
      its(:current_job_state_class) { is_expected.to be_nil }
    end
  end

  describe 'current_job_state_span' do
    before { locations_integration_setting.current_job = G5::Jobbing::Job.new(error_state: true, state: 'big-error') }
    its(:current_job_state_span) { is_expected.to eq("<span class=\"job-error\">big-error</span>") }
  end
end