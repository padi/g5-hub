require 'rails_helper'

describe ClientIntegrationSettingJobLoader do
  let(:clients_integration_setting) { Fabricate(:clients_integration_setting).tap { |cis| cis.integration_setting.create_job_setting(Fabricate.to_params(:job_setting)) } }
  let!(:locations_integration_setting_1) { Fabricate(:locations_integration_setting, location: Fabricate(:location), clients_integration_setting: clients_integration_setting) }
  let!(:locations_integration_setting_2) { Fabricate(:locations_integration_setting, location: Fabricate(:location), clients_integration_setting: clients_integration_setting) }
  let!(:locations_integration_setting_3) { Fabricate(:locations_integration_setting, location: Fabricate(:location), clients_integration_setting: clients_integration_setting) }

  describe :load_current_jobs_by_location do
    let(:job_1) { G5::Jobbing::Job.new(integration_setting_uid: locations_integration_setting_1.uid) }
    let(:job_2) { G5::Jobbing::Job.new(integration_setting_uid: locations_integration_setting_2.uid) }
    let(:job_madeup) { G5::Jobbing::Job.new(integration_setting_uid: 'madeup') }
    let(:retrieved_jobs) do
      [job_1, job_2, job_madeup]
    end

    before do
      expect(G5::Jobbing::JobRetriever).to receive(:new).with(location_setting_urns: clients_integration_setting.reload.locations_integration_settings.collect(&:urn)).
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

  describe :add_job_stats do
    let(:clients_integration_setting_2) { Fabricate(:clients_integration_setting) }
    let(:clients_integration_setting_3) { Fabricate(:clients_integration_setting) }

    let(:client_settings) { [clients_integration_setting, clients_integration_setting_2, clients_integration_setting_3] }
    let(:job_stat) { G5::Jobbing::JobStat.new(rolled_up_by: clients_integration_setting.id) }
    let(:job_stats) { {clients_integration_setting.id => job_stat} }

    before do
      expect(G5::Jobbing::JobStatRetriever).to receive(:new).with(rollup_by: ClientsIntegrationSetting.job_rollup_by(client_settings)).and_return(double(:perform, perform: job_stats))
      ClientsIntegrationSetting.add_job_stats(client_settings)
    end

    it 'adds job_stats to client settings' do
      expect(clients_integration_setting.job_stat).to eq(job_stat)
      expect(clients_integration_setting_2.job_stat).to be_nil
      expect(clients_integration_setting_3.job_stat).to be_nil
    end
  end

  describe :job_rollup_by do
    subject { ClientsIntegrationSetting.job_rollup_by([clients_integration_setting]) }
    let(:expected) do
      {clients_integration_setting.id => clients_integration_setting.locations_integration_settings.collect(&:urn)}
    end

    it 'rolls up by client settings' do
      expect(subject).to eq(expected)
    end
  end
end