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

  describe 'current job' do
    context 'with job' do
      let(:job) { Job.new(uid: 'uid', urn: 'urn', state: 'state', created_at: '12', updated_at: '14', message: 'my msg') }
      before do
        subject.current_job = job
      end
      its(:current_job_uid) { is_expected.to eq 'uid' }
      its(:current_job_urn) { is_expected.to eq 'urn' }
      its(:current_job_state) { is_expected.to eq 'state' }
      its(:current_job_created_at) { is_expected.to eq '12' }
      its(:current_job_updated_at) { is_expected.to eq '14' }
      its(:current_job_message) { is_expected.to eq 'my msg' }
    end
    context 'without job' do
      its(:current_job_uid) { is_expected.to be_nil }
      its(:current_job_state) { is_expected.to be_nil }
    end
  end
end