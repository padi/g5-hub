require 'rails_helper'

describe ClientIntegrationSettingJobLoader do
  let(:clients_integration_setting) { Fabricate(:clients_integration_setting).tap { |cis| cis.integration_setting.create_job_setting(Fabricate.to_params(:job_setting)) } }
  let!(:locations_integration_setting_1) { Fabricate(:locations_integration_setting, location: Fabricate(:location), clients_integration_setting: clients_integration_setting) }
  let!(:locations_integration_setting_2) { Fabricate(:locations_integration_setting, location: Fabricate(:location), clients_integration_setting: clients_integration_setting) }
  let!(:locations_integration_setting_3) { Fabricate(:locations_integration_setting, location: Fabricate(:location), clients_integration_setting: clients_integration_setting) }

  describe :load_current_jobs_by_location do
    let(:job_1) { Job.new(integration_setting_uid: locations_integration_setting_1.uid) }
    let(:job_2) { Job.new(integration_setting_uid: locations_integration_setting_2.uid) }
    let(:job_madeup) { Job.new(integration_setting_uid: 'madeup') }
    let(:retrieved_jobs) do
      [job_1, job_2, job_madeup]
    end

    before do
      expect(JobRetriever).to receive(:new).with(locations_integration_settings: clients_integration_setting.reload.locations_integration_settings).
                                  and_return(double(:result, perform: retrieved_jobs))
      clients_integration_setting.load_current_jobs_by_location
    end

    it 'sets the current job_1' do
      expect(clients_integration_setting.locations_integration_settings.exists? { |location_integ_sett| location_integ_sett.uid == job_1.integration_setting_uid && location_integ_sett.current_job == job_1 }).to be_truthy
    end

    it 'sets the current job_2' do
      expect(clients_integration_setting.locations_integration_settings.exists? { |location_integ_sett| location_integ_sett.uid == job_2.integration_setting_uid && location_integ_sett.current_job == job_2 }).to be_truthy
    end

    it 'does not set job when no match' do
      expect(clients_integration_setting.locations_integration_settings.detect { |lis| lis.uid == locations_integration_setting_3.uid }.current_job).to be_nil
    end
  end
end