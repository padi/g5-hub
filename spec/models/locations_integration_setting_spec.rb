require 'rails_helper'

describe LocationsIntegrationSetting do
  it { is_expected.to belong_to :location }
  it { is_expected.to belong_to :clients_integration_setting }
  it { is_expected.to belong_to :integration_setting }
  it { is_expected.to accept_nested_attributes_for(:integration_setting) }

  describe 'location / clients_integration_setting uniqueness' do
    let(:location) { Fabricate(:location) }
    let!(:first) { Fabricate(:locations_integration_setting, location: location) }
    let(:second) { Fabricate.build(:locations_integration_setting, location: location, clients_integration_setting: first.clients_integration_setting) }

    it 'does not allow duplicates' do
      expect(second).to_not be_valid
      expect(second.errors[:location_id]).to eq(['has already been taken'])
    end

    it 'sets URN when blank' do
      expect(first.urn).to_not be_nil
    end

    it 'does not set URN if already set' do
      urn = 'myurn'
      expect(Fabricate(:locations_integration_setting, urn: urn).urn).to eq(urn)
    end
  end

  describe 'Identifiers' do
    let(:location) { Fabricate(:location) }
    let(:locations_integration_setting) { Fabricate(:locations_integration_setting, location: location) }

    before do
      Time.any_instance.stub(:to_i) { 1325404800 }
    end

    it { expect(locations_integration_setting.hashed_id).to eq "#{locations_integration_setting.created_at.to_i}#{locations_integration_setting.id}".to_i.to_s(36) }
    it { expect(locations_integration_setting.urn).to eq "g5-lis-#{locations_integration_setting.hashed_id}" }
    it { expect(locations_integration_setting.to_param).to eq locations_integration_setting.urn }
  end

  describe :effective_job_setting do
    let(:client_job_setting) { Fabricate(:job_setting) }
    let(:clients_integration_setting) { Fabricate(:clients_integration_setting, integration_setting: Fabricate(:integration_setting, job_setting: client_job_setting)) }
    let(:locations_integration_setting) { Fabricate(:locations_integration_setting, clients_integration_setting: clients_integration_setting, location: Fabricate(:location), integration_setting: integration_setting) }
    let(:integration_setting) { Fabricate(:integration_setting) }

    subject { locations_integration_setting }

    context 'no job setting' do
      its(:effective_job_setting) { is_expected.to eq(client_job_setting) }
    end

    context 'with job setting' do
      let(:job_setting) { Fabricate(:job_setting) }
      let(:integration_setting) { Fabricate(:integration_setting, job_setting: job_setting) }
      its(:effective_job_setting) { is_expected.to eq(job_setting) }
    end

    context 'both client and location have no job_setting' do
      subject { Fabricate(:locations_integration_setting) }
      its(:effective_job_setting) { is_expected.to be_nil }
    end
  end

  describe 'current job' do
    context 'with job' do
      let(:job) { G5::Jobbing::Job.new(uid: 'uid', urn: 'urn', state: 'state', created_at: '12', updated_at: '14', message: 'my msg') }
      before do
        subject.current_job = job
      end
      its(:current_job_uid) { is_expected.to eq('uid') }
      its(:current_job_urn) { is_expected.to eq('urn') }
      its(:current_job_state) { is_expected.to eq('state') }
      its(:current_job_created_at) { is_expected.to eq('12') }
      its(:current_job_updated_at) { is_expected.to eq('14') }
      its(:current_job_message) { is_expected.to eq('my msg') }
      its(:current_job_logs_url) { is_expected.to eq('ENV[LOGS_BY_JOB_URL] not set!') }
    end
    context 'without job' do
      its(:current_job_uid) { is_expected.to be_nil }
      its(:current_job_state) { is_expected.to be_nil }
    end
  end

  describe :custom_value do
    let(:clients_integration_setting) { Fabricate(:clients_integration_setting, integration_setting: Fabricate(:integration_setting)) }
    let(:locations_integration_setting) { Fabricate(:locations_integration_setting, clients_integration_setting: clients_integration_setting, location: Fabricate(:location), integration_setting: integration_setting) }
    let(:integration_setting) { Fabricate(:integration_setting) }

    before do
      integration_setting.custom_integration_settings.create(name: 'foo', value: 'bar')
      clients_integration_setting.integration_setting.custom_integration_settings.create(name: 'foo', value: 'overridden')
      clients_integration_setting.integration_setting.custom_integration_settings.create(name: 'tofu', value: 'baz')
    end

    it 'uses own custom value if it exists' do
      expect(locations_integration_setting.custom_value('foo')).to eq('bar')
    end

    it "uses clients custom value if it doesn't have one" do
      expect(locations_integration_setting.custom_value('tofu')).to eq('baz')
    end

    it 'return nil if both client and location do not have custom value' do
      expect(locations_integration_setting.custom_value('madeup')).to be_nil
    end
  end
end